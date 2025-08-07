import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/models/travel.dart';
import 'package:travel_app/utils/helpers/date_utils.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';
import 'package:travel_app/viewmodels/home_viewmodel.dart';
import 'package:travel_app/services/data/travel_data_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripDetailsView extends StatelessWidget {
  final Travel trip;

  const TripDetailsView({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final TravelDataService travelDataService = TravelDataService();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: context.dynamicHeight(0.4),
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                trip.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              background: Hero(
                tag: 'tripImage-${trip.id}',
                child: Image.asset(
                  trip.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.image_not_supported,
                          size: context.dynamicWidth(0.2)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(context.dynamicWidth(0.05)),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${travelDataService.getLocalizedCountry(context, trip.country)}, ${travelDataService.getLocalizedRegion(context, trip.region)}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: context.dynamicHeight(0.01)),
                            Text(
                              '${DateUtil.formatDate(trip.startDate)} - ${DateUtil.formatDate(trip.endDate)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      Consumer<HomeViewModel>(
                        // Favourite status
                        builder: (context, homeViewModel, child) {
                          final currentTripIsFavorite =
                              homeViewModel.isTripFavorite(trip.id);
                          return IconButton(
                            icon: Icon(
                              currentTripIsFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: currentTripIsFavorite
                                  ? Colors.redAccent
                                  : Theme.of(context).colorScheme.onSurface,
                              size: context.dynamicWidth(0.08),
                            ),
                            onPressed: () {
                              homeViewModel.toggleFavorite(trip, context);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: context.dynamicHeight(0.02)),
                  Chip(
                    label: Text(
                      travelDataService.getLocalizedCategory(
                          context, trip.category),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(height: context.dynamicHeight(0.03)),
                  Text(
                    AppLocalizations.of(context)?.description ?? 'Description',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: context.dynamicHeight(0.01)),
                  Text(
                    trip.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: context.dynamicHeight(0.05)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
