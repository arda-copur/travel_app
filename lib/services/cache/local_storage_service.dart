import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/utils/constants/app_constants.dart';

class LocalStorageService {
  Future<List<String>> getFavoriteTripIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(AppConstants.favoritesKey) ?? [];
  }

  Future<void> saveFavoriteTripIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(AppConstants.favoritesKey, ids);
  }

  Future<String?> getFilterCountry() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.filterCountryKey);
  }

  Future<void> saveFilterCountry(String? country) async {
    final prefs = await SharedPreferences.getInstance();
    if (country == null) {
      await prefs.remove(AppConstants.filterCountryKey);
    } else {
      await prefs.setString(AppConstants.filterCountryKey, country);
    }
  }

  Future<String?> getFilterRegion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.filterRegionKey);
  }

  Future<void> saveFilterRegion(String? region) async {
    final prefs = await SharedPreferences.getInstance();
    if (region == null) {
      await prefs.remove(AppConstants.filterRegionKey);
    } else {
      await prefs.setString(AppConstants.filterRegionKey, region);
    }
  }

  Future<String?> getFilterCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.filterCategoryKey);
  }

  Future<void> saveFilterCategory(String? category) async {
    final prefs = await SharedPreferences.getInstance();
    if (category == null) {
      await prefs.remove(AppConstants.filterCategoryKey);
    } else {
      await prefs.setString(AppConstants.filterCategoryKey, category);
    }
  }

  Future<DateTime?> getFilterStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateString = prefs.getString(AppConstants.filterStartDateKey);
    return dateString != null ? DateTime.tryParse(dateString) : null;
  }

  Future<void> saveFilterStartDate(DateTime? date) async {
    final prefs = await SharedPreferences.getInstance();
    if (date == null) {
      await prefs.remove(AppConstants.filterStartDateKey);
    } else {
      await prefs.setString(
          AppConstants.filterStartDateKey, date.toIso8601String());
    }
  }

  Future<DateTime?> getFilterEndDate() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateString = prefs.getString(AppConstants.filterEndDateKey);
    return dateString != null ? DateTime.tryParse(dateString) : null;
  }

  Future<void> saveFilterEndDate(DateTime? date) async {
    final prefs = await SharedPreferences.getInstance();
    if (date == null) {
      await prefs.remove(AppConstants.filterEndDateKey);
    } else {
      await prefs.setString(
          AppConstants.filterEndDateKey, date.toIso8601String());
    }
  }

  Future<String> getViewMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.viewModeKey) ?? 'list';
  }

  Future<void> saveViewMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.viewModeKey, mode);
  }
}
