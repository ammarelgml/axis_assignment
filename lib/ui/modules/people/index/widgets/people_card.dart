import 'package:axis_assignment/data/models/person.dart';
import 'package:axis_assignment/ui/common/custom_cached_image.dart';
import 'package:axis_assignment/utils/constants.dart';
import 'package:axis_assignment/utils/dimensions_utils.dart';
import 'package:axis_assignment/utils/router/route_names.dart';
import 'package:flutter/material.dart';

class PeopleCard extends StatelessWidget {
  final People people;
  final bool isHorizontal;

  const PeopleCard({super.key, required this.people, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    double defWidth = isHorizontal ? screenAwareWidth(130, context) : MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).pushNamed(RouteNames.rPeopleDetailsPage, arguments: [people.id, people]);
      },
      child: Container(
        width: defWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            /// Image
            Positioned.fill(
              child: CustomCachedImage(
                image: people.profilePath.isNotEmpty ? '${Constants.imagesBaseUrl}/${people.profilePath}' : '',
                cornerRadius: 10,
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
