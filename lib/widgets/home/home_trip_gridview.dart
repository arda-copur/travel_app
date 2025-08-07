import 'package:flutter/material.dart';
import 'package:travel_app/models/travel.dart';
import 'package:travel_app/viewmodels/home_viewmodel.dart';
import 'package:travel_app/widgets/home/travel_grid_item.dart';
import 'package:travel_app/services/data/travel_data_service.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';
import 'package:travel_app/utils/route/app_routes.dart';

class HomeTripGridView extends StatelessWidget {
  final List<Travel> trips;
  final HomeViewModel viewModel;
  final TravelDataService travelDataService;

  const HomeTripGridView({
    super.key,
    required this.trips,
    required this.viewModel,
    required this.travelDataService,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(context.dynamicWidth(0.03)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            context.isSmallScreen ? 2 : (context.isMediumScreen ? 3 : 4),
        crossAxisSpacing: context.dynamicWidth(0.03),
        mainAxisSpacing: context.dynamicWidth(0.03),
        childAspectRatio: 0.7,
      ),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.tripDetails, arguments: trip);
          },
          child: TravelGridItem(
            trip: trip,
            onToggleFavorite: () => viewModel.toggleFavorite(trip, context),
            travelDataService: travelDataService,
          ),
        );
      },
    );
  }
}
