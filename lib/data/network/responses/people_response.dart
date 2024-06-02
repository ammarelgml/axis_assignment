import 'package:axis_assignment/data/models/person.dart';

class PeopleResponse {
  final List<People> people;
  final bool isLastPage;

  PeopleResponse({required this.people, required this.isLastPage});
}
