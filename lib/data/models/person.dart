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

  People copyWith({
    int? id,
    bool? adult,
    int? gender,
    String? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    List<KnownFor>? knownFor,
  }) =>
      People(
        id: id ?? this.id,
        adult: adult ?? this.adult,
        gender: gender ?? this.gender,
        knownForDepartment: knownForDepartment ?? this.knownForDepartment,
        name: name ?? this.name,
        originalName: originalName ?? this.originalName,
        popularity: popularity ?? this.popularity,
        profilePath: profilePath ?? this.profilePath,
        knownFor: knownFor ?? this.knownFor,
      );

  factory People.fromJson(Map<String, dynamic> json) => People(
        id: json.value<int>("id"),
        adult: json.value<bool>("adult"),
        gender: json.value<int>("gender"),
        knownForDepartment: json.value<String>("known_for_department"),
        name: json.value<String>("name"),
        originalName: json.value<String>("original_name"),
        popularity: json.value<double>("popularity"),
        profilePath: json.value<String>("profile_path"),
        knownFor: []
        // knownFor: json["known_for"] == null
        //     ? []
        //     : List<KnownFor>.from(json.value<List<dynamic>>("known_for").map((x) => KnownFor.fromJson(x))),
      );
}

class KnownFor {
  final int id;
  final String backdropPath;
  final String originalName;
  final String overview;
  final String posterPath;
  final String mediaType;
  final bool adult;
  final String name;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final DateTime firstAirDate;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;
  final String originalTitle;
  final String title;
  final DateTime releaseDate;
  final bool video;

  KnownFor({
    required this.id,
    required this.backdropPath,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.name,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
    required this.originalTitle,
    required this.title,
    required this.releaseDate,
    required this.video,
  });

  KnownFor copyWith({
    int? id,
    String? backdropPath,
    String? originalName,
    String? overview,
    String? posterPath,
    String? mediaType,
    bool? adult,
    String? name,
    String? originalLanguage,
    List<int>? genreIds,
    double? popularity,
    DateTime? firstAirDate,
    double? voteAverage,
    int? voteCount,
    List<String>? originCountry,
    String? originalTitle,
    String? title,
    DateTime? releaseDate,
    bool? video,
  }) =>
      KnownFor(
        id: id ?? this.id,
        backdropPath: backdropPath ?? this.backdropPath,
        originalName: originalName ?? this.originalName,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        mediaType: mediaType ?? this.mediaType,
        adult: adult ?? this.adult,
        name: name ?? this.name,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        genreIds: genreIds ?? this.genreIds,
        popularity: popularity ?? this.popularity,
        firstAirDate: firstAirDate ?? this.firstAirDate,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        originCountry: originCountry ?? this.originCountry,
        originalTitle: originalTitle ?? this.originalTitle,
        title: title ?? this.title,
        releaseDate: releaseDate ?? this.releaseDate,
        video: video ?? this.video,
      );

  factory KnownFor.fromJson(Map<String, dynamic> json) => KnownFor(
        id: json.value<int>("id"),
        backdropPath: json.value<String>("backdrop_path"),
        originalName: json.value<String>("original_name"),
        overview: json.value<String>("overview"),
        posterPath: json.value<String>("poster_path"),
        mediaType: json.value<String>("media_type"),
        adult: json.value<bool>("adult"),
        name: json.value<String>("name"),
        originalLanguage: json.value<String>("original_language"),
        genreIds: json["genre_ids"] == null ? [] : List<int>.from(json.value<List<dynamic>>("genre_ids").map((x) => x)),
        popularity: json.value<double>("popularity"),
        firstAirDate: DateTime.parse(json.value<String>("first_air_date")),
        voteAverage: json.value<double>("vote_average"),
        voteCount: json.value<int>("vote_count"),
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json.value<List<dynamic>>("origin_country").map((x) => x)),
        originalTitle: json.value<String>("original_title"),
        title: json.value<String>("title"),
        releaseDate: DateTime.parse(json.value<String>("release_date")),
        video: json.value<bool>("video"),
      );
}
