import 'package:flutter/material.dart';
import 'package:travel_app/models/travel.dart';
import 'package:travel_app/services/cache/local_storage_service.dart';
import 'package:travel_app/services/data/travel_data_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travel_app/views/gemini_chat_view.dart';

class HomeViewModel extends ChangeNotifier {
  final TravelDataService _travelDataService = TravelDataService();
  final LocalStorageService _localStorageService = LocalStorageService();

  List<Travel> _allTrips = [];
  List<Travel> _filteredTrips = [];
  List<Travel> get filteredTrips => _filteredTrips;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _selectedCountry;
  String? get selectedCountry => _selectedCountry;

  String? _selectedRegion;
  String? get selectedRegion => _selectedRegion;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  DateTime? _selectedStartDate;
  DateTime? get selectedStartDate => _selectedStartDate;

  DateTime? _selectedEndDate;
  DateTime? get selectedEndDate => _selectedEndDate;

  String _viewMode = 'list';
  String get viewMode => _viewMode;
  // Loads initial data when the home screen is opened
  Future<void> loadInitialData(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _allTrips = await _travelDataService.loadTravelData();
    await _loadFavorites();
    await _loadFilters(context);
    await _loadViewMode();
    _applyFilters(context);

    _isLoading = false;
    notifyListeners();
  }

  // Loads favorite trip IDs from local storage and updates trip list
  Future<void> _loadFavorites() async {
    final favoriteIds = await _localStorageService.getFavoriteTripIds();
    for (var trip in _allTrips) {
      trip.isFavorite = favoriteIds.contains(trip.id);
    }
  }

  // Loads saved filters from local storage
  Future<void> _loadFilters(BuildContext context) async {
    final countryKey = await _localStorageService.getFilterCountry();
    _selectedCountry = countryKey != null && countryKey != 'All'
        ? _travelDataService.getLocalizedCountry(context, countryKey)
        : countryKey;

    final regionKey = await _localStorageService.getFilterRegion();
    _selectedRegion = regionKey != null && regionKey != 'All'
        ? _travelDataService.getLocalizedRegion(context, regionKey)
        : regionKey;

    final categoryKey = await _localStorageService.getFilterCategory();
    _selectedCategory = categoryKey != null && categoryKey != 'All'
        ? _travelDataService.getLocalizedCategory(context, categoryKey)
        : categoryKey;

    _selectedStartDate = await _localStorageService.getFilterStartDate();
    _selectedEndDate = await _localStorageService.getFilterEndDate();
  }

  // Loads saved view mode from local storage
  Future<void> _loadViewMode() async {
    _viewMode = await _localStorageService.getViewMode();
  }

  void toggleFavorite(Travel trip, BuildContext context) {
    // BuildContext eklendi
    final index = _allTrips.indexWhere((t) => t.id == trip.id);
    if (index != -1) {
      _allTrips[index] =
          _allTrips[index].copyWith(isFavorite: !trip.isFavorite);
      _saveFavorites();
      _applyFilters(
          context); // Favori durumu değiştiğinde filtreleri yeniden uygula
      // notifyListeners(); // _applyFilters zaten notifyListeners çağırıyor
    }
  }

  Future<void> _saveFavorites() async {
    final favoriteIds = _allTrips
        .where((trip) => trip.isFavorite)
        .map((trip) => trip.id)
        .toList();
    await _localStorageService.saveFavoriteTripIds(favoriteIds);
  }

  // Applies current filters to the list of all trips
  void applyFilters(
    BuildContext context, {
    String? country,
    String? region,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    _selectedCountry = country ?? _selectedCountry;
    _selectedRegion = region ?? _selectedRegion;
    _selectedCategory = category ?? _selectedCategory;
    _selectedStartDate = startDate ?? _selectedStartDate;
    _selectedEndDate = endDate ?? _selectedEndDate;

    _saveFilters(context);
    _applyFilters(context);
  }

  // Saves the currently selected filters
  Future<void> _saveFilters(BuildContext context) async {
    await _localStorageService.saveFilterCountry(_selectedCountry != null &&
            _selectedCountry != (AppLocalizations.of(context)?.all ?? 'All')
        ? _travelDataService.getCountryKeyFromLocalized(
            context, _selectedCountry!)
        : _selectedCountry);
    await _localStorageService.saveFilterRegion(_selectedRegion != null &&
            _selectedRegion != (AppLocalizations.of(context)?.all ?? 'All')
        ? _travelDataService.getRegionKeyFromLocalized(
            context, _selectedRegion!)
        : _selectedRegion);
    await _localStorageService.saveFilterCategory(_selectedCategory != null &&
            _selectedCategory != (AppLocalizations.of(context)?.all ?? 'All')
        ? _travelDataService.getCategoryKeyFromLocalized(
            context, _selectedCategory!)
        : _selectedCategory);
    await _localStorageService.saveFilterStartDate(_selectedStartDate);
    await _localStorageService.saveFilterEndDate(_selectedEndDate);
  }

  void _applyFilters(BuildContext context) {
    _filteredTrips = _allTrips.where((trip) {
      bool matchesCountry = _selectedCountry == null ||
          _selectedCountry == (AppLocalizations.of(context)?.all ?? 'All') ||
          trip.country ==
              _travelDataService.getCountryKeyFromLocalized(
                  context, _selectedCountry!);

      bool matchesRegion = _selectedRegion == null ||
          _selectedRegion == (AppLocalizations.of(context)?.all ?? 'All') ||
          trip.region ==
              _travelDataService.getRegionKeyFromLocalized(
                  context, _selectedRegion!);

      bool matchesCategory = _selectedCategory == null ||
          _selectedCategory == (AppLocalizations.of(context)?.all ?? 'All') ||
          trip.category ==
              _travelDataService.getCategoryKeyFromLocalized(
                  context, _selectedCategory!);

      bool matchesStartDate = _selectedStartDate == null ||
          DateTime.parse(trip.startDate).isAfter(_selectedStartDate!) ||
          DateTime.parse(trip.startDate).isAtSameMomentAs(_selectedStartDate!);
      bool matchesEndDate = _selectedEndDate == null ||
          DateTime.parse(trip.endDate).isBefore(_selectedEndDate!) ||
          DateTime.parse(trip.endDate).isAtSameMomentAs(_selectedEndDate!);

      return matchesCountry &&
          matchesRegion &&
          matchesCategory &&
          matchesStartDate &&
          matchesEndDate;
    }).toList();
    notifyListeners();
  }

  void resetFilters(BuildContext context) {
    _selectedCountry = null;
    _selectedRegion = null;
    _selectedCategory = null;
    _selectedStartDate = null;
    _selectedEndDate = null;
    _saveFilters(context);
    _applyFilters(context);
  }

  // Toggles view mode between list and grid
  void toggleViewMode() {
    _viewMode = _viewMode == 'list' ? 'grid' : 'list';
    _localStorageService.saveViewMode(_viewMode);
    notifyListeners();
  }

  List<String> getUniqueRegionsForSelectedCountry(BuildContext context) {
    final String? countryKey = _selectedCountry != null &&
            _selectedCountry != (AppLocalizations.of(context)?.all ?? 'All')
        ? _travelDataService.getCountryKeyFromLocalized(
            context, _selectedCountry!)
        : null;

    Set<String> regions = {};
    regions.add(AppLocalizations.of(context)?.all ?? 'All');

    if (countryKey == null || countryKey == 'All') {
      _allTrips
          .map((e) => _travelDataService.getLocalizedRegion(context, e.region))
          .forEach(regions.add);
    } else {
      _allTrips
          .where((trip) => trip.country == countryKey)
          .map((e) => _travelDataService.getLocalizedRegion(context, e.region))
          .forEach(regions.add);
    }
    return regions.toList();
  }

  List<String> getUniqueCountries(BuildContext context) {
    Set<String> countries = {};
    countries.add(AppLocalizations.of(context)?.all ?? 'All');

    _allTrips
        .map((e) => _travelDataService.getLocalizedCountry(context, e.country))
        .forEach(countries.add);

    return countries.toList();
  }

  List<String> getUniqueCategories(BuildContext context) {
    Set<String> categories = {};
    categories.add(AppLocalizations.of(context)?.all ?? 'All');
    _allTrips
        .map(
            (e) => _travelDataService.getLocalizedCategory(context, e.category))
        .forEach(categories.add);
    return categories.toList();
  }

  List<Travel> get favoriteTrips =>
      _allTrips.where((trip) => trip.isFavorite).toList();

  bool isTripFavorite(String tripId) {
    return _allTrips
        .firstWhere((trip) => trip.id == tripId,
            orElse: () => Travel(
                id: '',
                title: '',
                country: '',
                region: '',
                startDate: '',
                endDate: '',
                category: '',
                description: '',
                imagePath: ''))
        .isFavorite;
  }

  void showChatDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const GeminiChatView(),
    );
  }
}
