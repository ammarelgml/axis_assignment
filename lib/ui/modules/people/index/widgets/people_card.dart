import 'package:axis_assignment/data/models/person.dart';
import 'package:axis_assignment/ui/common/custom_cached_image.dart';
import 'package:axis_assignment/utils/constants.dart';
import 'package:axis_assignment/utils/dimensions_utils.dart';
import 'package:axis_assignment/utils/router/route_names.dart';
import 'package:axis_assignment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PeopleCard extends StatelessWidget {
  final People people;

  const PeopleCard({super.key, required this.people});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await Utils.networkIsConnective()) {
          if (!context.mounted) return;
          await Navigator.of(context).pushNamed(RouteNames.rPeopleDetailsPage, arguments: people);
        } else {
          if (!context.mounted) return;
          Utils.showToast(message: S.of(context)!.noInternetConnection);
        }
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            /// Image
            Positioned.fill(
              child: Hero(
                tag: people.profilePath,
                child: CustomCachedImage(
                  image: people.profilePath.isNotEmpty ? '${Constants.imagesBaseUrl}/${people.profilePath}' : '',
                ),
              ),
            ),

            /// Bottom Shadow
            PositionedDirectional(
              bottom: 0.0,
              start: 0.0,
              end: 0.0,
              child: Container(
                height: screenAwareWidth(60, context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.bottomCenter,
                    end: AlignmentDirectional.topCenter,
                    colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                  ),
                ),
              ),
            ),

            /// Name & Job
            PositionedDirectional(
              start: 8.0,
              end: 8.0,
              bottom: 8.0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      people.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                  Text(
                    people.knownForDepartment,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
