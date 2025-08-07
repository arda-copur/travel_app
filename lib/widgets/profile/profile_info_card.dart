import 'package:flutter/material.dart';
import 'package:travel_app/utils/extensions/media_query_extension.dart';

class ProfileInfoCard extends StatelessWidget {
  final String label;
  final Widget content;

  const ProfileInfoCard({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.dynamicWidth(0.04),
          vertical: context.dynamicHeight(0.02),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: context.dynamicHeight(0.008)),
            content,
          ],
        ),
      ),
    );
  }
}
