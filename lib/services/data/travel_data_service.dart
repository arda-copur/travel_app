import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_app/models/travel.dart';
import 'package:travel_app/services/cache/local_storage_service.dart';
import 'package:travel_app/utils/constants/app_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//Localization of static parts of the data for each language
class TravelDataService {
  final LocalStorageService _localStorageService = LocalStorageService();

  LocalStorageService get localStorageService => _localStorageService;

  Future<List<Travel>> loadTravelData() async {
    try {
      final List<dynamic> jsonList = json.decode(AppConstants.travelJsonData);
      return jsonList.map((json) => Travel.fromJson(json)).toList();
    } catch (e) {
      print('Error loading travel data: $e');
      return [];
    }
  }

  String getLocalizedCategory(BuildContext context, String categoryKey) {
    switch (categoryKey) {
      case 'culture':
        return AppLocalizations.of(context)?.culture ?? 'Culture';
      case 'festival':
        return AppLocalizations.of(context)?.festival ?? 'Festival';
      case 'adventure':
        return AppLocalizations.of(context)?.adventure ?? 'Adventure';
      case 'art':
        return AppLocalizations.of(context)?.art ?? 'Art';
      case 'gastronomy':
        return AppLocalizations.of(context)?.gastronomy ?? 'Gastronomy';
      case 'history':
        return AppLocalizations.of(context)?.history ?? 'History';
      case 'nature':
        return AppLocalizations.of(context)?.nature ?? 'Nature';
      default:
        return categoryKey;
    }
  }

  String getCategoryKeyFromLocalized(
      BuildContext context, String localizedCategory) {
    if (localizedCategory == (AppLocalizations.of(context)?.all ?? 'All')) {
      return 'All';
    }
    if (localizedCategory ==
        (AppLocalizations.of(context)?.culture ?? 'Culture')) {
      return 'culture';
    }
    if (localizedCategory ==
        (AppLocalizations.of(context)?.festival ?? 'Festival')) {
      return 'festival';
    }
    if (localizedCategory ==
        (AppLocalizations.of(context)?.adventure ?? 'Adventure')) {
      return 'adventure';
    }
    if (localizedCategory == (AppLocalizations.of(context)?.art ?? 'Art')) {
      return 'art';
    }
    if (localizedCategory ==
        (AppLocalizations.of(context)?.gastronomy ?? 'Gastronomy')) {
      return 'gastronomy';
    }
    if (localizedCategory ==
        (AppLocalizations.of(context)?.history ?? 'History')) {
      return 'history';
    }
    if (localizedCategory ==
        (AppLocalizations.of(context)?.nature ?? 'Nature')) {
      return 'nature';
    }
    return localizedCategory;
  }

  String getLocalizedCountry(BuildContext context, String countryKey) {
    switch (countryKey) {
      case 'germany':
        return AppLocalizations.of(context)?.countryGermany ?? 'Germany';
      case 'austria':
        return AppLocalizations.of(context)?.countryAustria ?? 'Austria';
      case 'switzerland':
        return AppLocalizations.of(context)?.countrySwitzerland ??
            'Switzerland';
      default:
        return countryKey;
    }
  }

  String getCountryKeyFromLocalized(
      BuildContext context, String localizedCountry) {
    if (localizedCountry == (AppLocalizations.of(context)?.all ?? 'All')) {
      return 'All';
    }
    if (localizedCountry ==
        (AppLocalizations.of(context)?.countryGermany ?? 'Germany')) {
      return 'germany';
    }
    if (localizedCountry ==
        (AppLocalizations.of(context)?.countryAustria ?? 'Austria')) {
      return 'austria';
    }
    if (localizedCountry ==
        (AppLocalizations.of(context)?.countrySwitzerland ?? 'Switzerland')) {
      return 'switzerland';
    }
    return localizedCountry;
  }

  String getLocalizedRegion(BuildContext context, String regionKey) {
    switch (regionKey) {
      case 'berlin':
        return AppLocalizations.of(context)?.regionBerlin ?? 'Berlin';
      case 'wien':
        return AppLocalizations.of(context)?.regionWien ?? 'Wien';
      case 'valais':
        return AppLocalizations.of(context)?.regionValais ?? 'Valais';
      case 'bayern':
        return AppLocalizations.of(context)?.regionBayern ?? 'Bayern';
      case 'geneve':
        return AppLocalizations.of(context)?.regionGeneve ?? 'Genève';
      case 'zurich':
        return AppLocalizations.of(context)?.regionZurich ?? 'Zürich';
      case 'tirol':
        return AppLocalizations.of(context)?.regionTirol ?? 'Tirol';
      case 'vorarlberg':
        return AppLocalizations.of(context)?.regionVorarlberg ?? 'Vorarlberg';
      case 'hamburg':
        return AppLocalizations.of(context)?.regionHamburg ?? 'Hamburg';
      case 'sachsen':
        return AppLocalizations.of(context)?.regionSachsen ?? 'Sachsen';
      case 'bern':
        return AppLocalizations.of(context)?.regionBern ?? 'Bern';
      default:
        return regionKey;
    }
  }

  String getRegionKeyFromLocalized(
      BuildContext context, String localizedRegion) {
    if (localizedRegion == (AppLocalizations.of(context)?.all ?? 'All')) {
      return 'All';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionBerlin ?? 'Berlin')) {
      return 'berlin';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionWien ?? 'Wien')) {
      return 'wien';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionValais ?? 'Valais')) {
      return 'valais';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionBayern ?? 'Bayern')) {
      return 'bayern';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionGeneve ?? 'Genève')) {
      return 'geneve';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionZurich ?? 'Zürich')) {
      return 'zurich';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionTirol ?? 'Tirol')) {
      return 'tirol';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionVorarlberg ?? 'Vorarlberg')) {
      return 'vorarlberg';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionHamburg ?? 'Hamburg')) {
      return 'hamburg';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionSachsen ?? 'Sachsen')) {
      return 'sachsen';
    }
    if (localizedRegion ==
        (AppLocalizations.of(context)?.regionBern ?? 'Bern')) {
      return 'bern';
    }
    return localizedRegion;
  }
}
