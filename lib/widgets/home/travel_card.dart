import 'package:flutter/material.dart';
import 'package:travel_app/models/travel.dart';
import 'package:travel_app/services/data/travel_data_service.dart';
import 'package:travel_app/utils/helpers/date_utils.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';

class TravelCard extends StatelessWidget {
  final Travel trip;
  final VoidCallback onToggleFavorite;
  final TravelDataService travelDataService;

  const TravelCard({
    super.key,
    required this.trip,
    required this.onToggleFavorite,
    required this.travelDataService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: context.dynamicWidth(0.04),
        vertical: context.dynamicHeight(0.015),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10, // Daha belirgin gölge
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                trip.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: context.dynamicHeight(0.28),
                errorBuilder: (context, error, stackTrace) => Container(
                  height: context.dynamicHeight(0.28),
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.image_not_supported,
                        size: context.dynamicWidth(0.1)),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      trip.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: trip.isFavorite ? Colors.redAccent : Colors.white,
                      size: 30, // İkon boyutu
                    ),
                    onPressed: onToggleFavorite,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(context.dynamicWidth(0.05)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.dynamicHeight(0.015)),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 20, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${travelDataService.getLocalizedCountry(context, trip.country)}, ${travelDataService.getLocalizedRegion(context, trip.region)}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.8),
                                ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.dynamicHeight(0.01)),
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 18, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${DateUtil.formatDate(trip.startDate)} - ${DateUtil.formatDate(trip.endDate)}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.dynamicHeight(0.02)),
                Text(
                  trip.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.dynamicHeight(0.02)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Chip(
                    label: Text(
                      travelDataService.getLocalizedCategory(
                          context, trip.category),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
