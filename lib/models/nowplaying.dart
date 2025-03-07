class NowPlaying {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final List<int> genreIds;
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
