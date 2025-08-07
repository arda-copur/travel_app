import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/viewmodels/home_viewmodel.dart';
import 'package:travel_app/widgets/home/filter_dialog.dart';

class FilterDialogLauncher {
  static void show(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return FilterDialog(
          initialCountry: homeViewModel.selectedCountry,
          initialRegion: homeViewModel.selectedRegion,
          initialCategory: homeViewModel.selectedCategory,
          initialStartDate: homeViewModel.selectedStartDate,
          initialEndDate: homeViewModel.selectedEndDate,
          countries: homeViewModel.getUniqueCountries(context),
          regions: homeViewModel.getUniqueRegionsForSelectedCountry(context),
          categories: homeViewModel.getUniqueCategories(context),
          onApplyFilters: (country, region, category, startDate, endDate) {
            homeViewModel.applyFilters(
              context,
              country: country,
              region: region,
              category: category,
              startDate: startDate,
              endDate: endDate,
            );
            Navigator.of(dialogContext).pop();
          },
          onResetFilters: () {
            homeViewModel.resetFilters(context);
            Navigator.of(dialogContext).pop();
          },
        );
      },
    );
  }
}
