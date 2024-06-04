import 'package:axis_assignment/utils/null_mapper.dart';

class People {
  final int id;
  final String name;
  final String knownForDepartment;
   String profilePath;
  final double popularity;

  People({
    required this.id,
    required this.name,
    required this.knownForDepartment,
    required this.profilePath,
    required this.popularity,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
        id: json.value<int>("id"),
        knownForDepartment: json.value<String>("known_for_department"),
        name: json.value<String>("name"),
        popularity: json.value<double>("popularity"),
        profilePath: json.value<String>("profile_path"),
      );
}
