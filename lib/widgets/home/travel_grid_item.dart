import 'package:flutter/material.dart';
import 'package:travel_app/models/travel.dart';
import 'package:travel_app/services/data/travel_data_service.dart';
import 'package:travel_app/utils/helpers/date_utils.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';

class TravelGridItem extends StatelessWidget {
  final Travel trip;
  final VoidCallback onToggleFavorite;
  final TravelDataService travelDataService;

  const TravelGridItem({
    super.key,
    required this.trip,
    required this.onToggleFavorite,
    required this.travelDataService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Image.asset(
                  trip.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.image_not_supported,
                          size: context.dynamicWidth(0.08)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        trip.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            trip.isFavorite ? Colors.redAccent : Colors.white,
                        size: 26,
                      ),
                      onPressed: onToggleFavorite,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(context.dynamicWidth(0.03)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.dynamicHeight(0.008)),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${travelDataService.getLocalizedCountry(context, trip.country)}, ${travelDataService.getLocalizedRegion(context, trip.region)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.dynamicHeight(0.005)),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 14,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${DateUtil.formatDate(trip.startDate)} - ${DateUtil.formatDate(trip.endDate)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Chip(
                      label: Text(
                        travelDataService.getLocalizedCategory(
                            context, trip.category),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
