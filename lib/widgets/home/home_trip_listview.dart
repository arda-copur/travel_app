import 'package:flutter/material.dart';
import 'package:travel_app/models/travel.dart';
import 'package:travel_app/viewmodels/home_viewmodel.dart';
import 'package:travel_app/widgets/home/travel_card.dart';
import 'package:travel_app/services/data/travel_data_service.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';
import 'package:travel_app/utils/route/app_routes.dart';

class HomeTripListView extends StatelessWidget {
  final List<Travel> trips;
  final HomeViewModel viewModel;
  final TravelDataService travelDataService;

  const HomeTripListView({
    super.key,
    required this.trips,
    required this.viewModel,
    required this.travelDataService,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trips.length,
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      itemBuilder: (context, index) {
        final trip = trips[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.tripDetails, arguments: trip);
          },
          child: TravelCard(
            trip: trip,
            onToggleFavorite: () => viewModel.toggleFavorite(trip, context),
            travelDataService: travelDataService,
          ),
        );
      },
    );
  }
}
