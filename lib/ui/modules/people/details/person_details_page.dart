import 'package:axis_assignment/bloc/people/images/index/bloc.dart';
import 'package:axis_assignment/data/models/person.dart';
import 'package:axis_assignment/data/repositories/people_repo.dart';
import 'package:axis_assignment/ui/common/custom_cached_image.dart';
import 'package:axis_assignment/ui/common/loading_widget.dart';
import 'package:axis_assignment/utils/constants.dart';
import 'package:axis_assignment/utils/dimensions_utils.dart';
import 'package:axis_assignment/utils/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_view/photo_view.dart';

class PersonDetailsPage extends StatefulWidget {
  const PersonDetailsPage({super.key, required this.people});

  final People people;

  @override
  State<PersonDetailsPage> createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  late final ImagesBloc personImageBloc;

  @override
  void initState() {
    super.initState();
    personImageBloc = ImagesBloc(PeopleDataRepository())..add(GetPersonImages(widget.people.id));
  }

  @override
  void dispose() {
    personImageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              /// Name & Job
              SliverAppBar(
                elevation: 4,
                expandedHeight: screenAwareHeight(180, context),
                collapsedHeight: screenAwareHeight(180, context),
                toolbarHeight: screenAwareHeight(180, context),
                floating: false,
                pinned: true,
                snap: false,
                stretch: true,
                leading: const SizedBox(),
                leadingWidth: 0,
                titleSpacing: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 16, end: 16, top: 54.0, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                widget.people.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  S.of(context)!.department,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                                Text(
                                  widget.people.knownForDepartment,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.zero,
                ),
              ),

              /// Content
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Known For & Popularity
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  S.of(context)!.images,
                                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 28),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '${S.of(context)!.popularity}: ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    TextSpan(
                                      text: widget.people.popularity.toString(),
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    )
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        /// Images
                        BlocBuilder<ImagesBloc, ImagesState>(
                            bloc: personImageBloc,
                            builder: (context, state) {
                              if (state is LoadedImagesState) {
                                return GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.8,
                                  shrinkWrap: true,
                                  padding: const EdgeInsetsDirectional.only(top: 8, start: 16, end: 16, bottom: 32),
                                  cacheExtent: 1.0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: state.imagesList
                                      .map(
                                        (image) => GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(RouteNames.rImagePreviewPage, arguments: image);
                                          },
                                          child: CustomCachedImage(
                                            image: image.filePath.isNotEmpty
                                                ? '${Constants.imagesBaseUrl}/${image.filePath}'
                                                : '',
                                            cornerRadius: 10,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              } else if (state is LoadingImagesState) {
                                return const LoadingWidget();
                              }
                              return const SizedBox();
                            }),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
