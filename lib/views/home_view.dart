import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/services/data/travel_data_service.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';
import 'package:travel_app/utils/route/app_routes.dart';
import 'package:travel_app/viewmodels/home_viewmodel.dart';
import 'package:travel_app/widgets/home/filter_dialog_launcher.dart';
import 'package:travel_app/widgets/home/home_trip_gridview.dart';
import 'package:travel_app/widgets/home/home_trip_listview.dart';
import 'package:travel_app/widgets/home/language_switcher_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TravelDataService _travelDataService = TravelDataService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false)
          .loadInitialData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.homeTitle ?? 'Travel Plans'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_alt),
            tooltip: AppLocalizations.of(context)?.filter ?? 'Filter',
            onPressed: () {
              FilterDialogLauncher.show(context);
            },
          ),
          Consumer<HomeViewModel>(
            builder: (context, homeViewModel, child) {
              return IconButton(
                icon: Icon(
                  homeViewModel.viewMode == 'list'
                      ? Icons.grid_view_rounded
                      : Icons.list_alt_rounded,
                ),
                tooltip: homeViewModel.viewMode == 'list'
                    ? (AppLocalizations.of(context)?.switchToGrid ??
                        'Switch to Grid View')
                    : (AppLocalizations.of(context)?.switchToList ??
                        'Switch to List View'),
                onPressed: () {
                  homeViewModel.toggleViewMode();
                },
              );
            },
          ),
          Consumer<HomeViewModel>(
            builder: (context, homeViewModel, child) {
              return IconButton(
                icon: const Icon(Icons.smart_toy_rounded),
                tooltip: AppLocalizations.of(context)?.travelAssistant ??
                    'Travel Assistant',
                onPressed: () => homeViewModel.showChatDialog(context),
              );
            },
          ),
          const LanguageSwitcherButton(),
          IconButton(
            icon: const Icon(Icons.person_rounded),
            tooltip: AppLocalizations.of(context)?.profileTitle ?? 'Profile',
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.profile);
            },
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          if (homeViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (homeViewModel.filteredTrips.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sentiment_dissatisfied_rounded,
                      size: context.dynamicWidth(0.2),
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6)),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  Text(
                    AppLocalizations.of(context)?.noTripsFound ??
                        'No trips found.',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return homeViewModel.viewMode == 'list'
              ? HomeTripListView(
                  trips: homeViewModel.filteredTrips,
                  viewModel: homeViewModel,
                  travelDataService: _travelDataService,
                )
              : HomeTripGridView(
                  trips: homeViewModel.filteredTrips,
                  viewModel: homeViewModel,
                  travelDataService: _travelDataService,
                );
        },
      ),
    );
  }
}
