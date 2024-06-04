import 'package:axis_assignment/data/models/person.dart';
import 'package:axis_assignment/data/repositories/people_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'event.dart';

part 'state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  late PagingController<int, People> pagingController;
  final PeopleRepository _peopleRepository;

  PeopleBloc(this._peopleRepository) : super(PeopleInitial()) {
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      loadPeopleNextPage(pageKey);
    });
  }

  Future<void> loadPeopleNextPage(int pageKey) async {
    (await _peopleRepository.getPeople(page: pageKey)).fold(
      (error) {
        pagingController.error = error.message;
      },
      (peopleResponse) {
        if (peopleResponse.isLastPage) {
          pagingController.appendLastPage(peopleResponse.people);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(peopleResponse.people, nextPageKey);
        }
      },
    );
  }

  void refreshPeople() {
    pagingController.refresh();
  }

  void retryPeople() {
    pagingController.retryLastFailedRequest();
  }
}
