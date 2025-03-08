import 'package:hive/hive.dart';

part 'nowplaying.g.dart';

@HiveType(typeId: 1)
class NowPlaying {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  final String posterPath;

  @HiveField(4)
  final String backdropPath;

  @HiveField(5)
  final double voteAverage;

  @HiveField(6)
  final List<int> genreIds;

  @HiveField(7)
  final String releaseDate;

  NowPlaying({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.genreIds,
    required this.releaseDate,
  });

  factory NowPlaying.fromJson(Map<String, dynamic> json) {
    return NowPlaying(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'].toDouble(),
      genreIds: List<int>.from(json['genre_ids']),
      releaseDate: json['release_date'],
    );
  }
}
