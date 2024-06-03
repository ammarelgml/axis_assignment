import 'package:axis_assignment/utils/null_mapper.dart';

class People {
  final int id;
  final bool adult;
  final int gender;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final List<KnownFor> knownFor;

  People({
    required this.id,
    required this.adult,
    required this.gender,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.knownFor,
  });

  factory People.fromJson(Map<String, dynamic> json) => People(
        id: json.value<int>("id"),
        adult: json.value<bool>("adult"),
        gender: json.value<int>("gender"),
        knownForDepartment: json.value<String>("known_for_department"),
        name: json.value<String>("name"),
        originalName: json.value<String>("original_name"),
        popularity: json.value<double>("popularity"),
        profilePath: json.value<String>("profile_path"),
        knownFor: json["known_for"] == null
            ? []
            : List<KnownFor>.generate(json["known_for"].length, (index) => KnownFor.fromJson(json["known_for"][index])),
      );
}

class KnownFor {
  final int id;
  final String backdropPath;
  final String posterPath;

  KnownFor({required this.id, required this.backdropPath, required this.posterPath});

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        id: json.value<int>("id"),
        backdropPath: json.value<String>("backdrop_path"),
        posterPath: json.value<String>("poster_path"),
      );
}
