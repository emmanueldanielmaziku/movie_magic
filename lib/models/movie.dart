import 'package:hive/hive.dart';

part 'movie.g.dart';

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'] ?? '',
      iso6391: json['iso_639_1'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  final String posterPath;

  @HiveField(4)
  final double voteAverage;

  @HiveField(5)
  final List<String> genres;

  @HiveField(6)
  final int runtime;

  @HiveField(7)
  final String releaseDate;

  @HiveField(8)
  final int voteCount;

  @HiveField(9)
  final List<SpokenLanguage> spokenLanguages;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genres,
    required this.runtime,
    required this.releaseDate,
    required this.voteCount,
    required this.spokenLanguages,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
      runtime: json['runtime'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      voteCount: json['vote_count'] ?? 0,
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
              ?.map((language) => SpokenLanguage.fromJson(language))
              .toList() ??
          [],
    );
  }
}
