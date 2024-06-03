import 'package:axis_assignment/bloc/people/index/bloc.dart';
import 'package:axis_assignment/data/models/person.dart';
import 'package:axis_assignment/data/repositories/people_repo.dart';
import 'package:axis_assignment/ui/common/genearic_state.dart';
import 'package:axis_assignment/ui/common/loading_widget.dart';
import 'package:axis_assignment/ui/modules/people/index/widgets/people_card.dart';
import 'package:axis_assignment/utils/dimensions_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  late PeopleBloc _peopleBloc;

  @override
  void initState() {
    super.initState();

    _peopleBloc = PeopleBloc(PeopleDataRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context)!.people)),
      body: PagedGridView<int, People>(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        padding: const EdgeInsetsDirectional.only(top: 8, start: 16, end: 16, bottom: 32),
        physics: const BouncingScrollPhysics(),
        cacheExtent: 1.0,
        pagingController: _peopleBloc.pagingController,
        builderDelegate: PagedChildBuilderDelegate<People>(
          itemBuilder: (context, item, index) => PeopleCard(people: item, isHorizontal: false),
          firstPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: screenAwareHeight(200, context),
              child: const Center(child: LoadingWidget()),
            );
          },
          firstPageErrorIndicatorBuilder: (_) {
            return Center(
              child: GenericState(
                size: 40,
                fontSize: 16,
                removeButton: false,
                onPress: () => _peopleBloc.refreshPeople(),
                state: GenericStateTypes.ERROR,
                buttonKey: S.of(context)!.tryAgain,
                bodyKey: '${_peopleBloc.pagingController.error}',
              ),
            );
          },
          newPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
          newPageErrorIndicatorBuilder: (_) => const SizedBox(height: 16),
          noItemsFoundIndicatorBuilder: (_) => Center(
            child: GenericState(
              removeButton: true,
              state: GenericStateTypes.EMPTY,
              titleKey: S.of(context)!.noActorsAvailable,
            ),
          ),
        ),
      ),
    );
  }
}
