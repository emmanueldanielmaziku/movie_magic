class Movie {
  final String title;
  final String imageUrl;
  final bool isContinueWatching;
  final bool isSaved;
  final String duration;

  Movie({
    required this.title,
    required this.imageUrl,
    this.isContinueWatching = false,
    this.isSaved = true,
    this.duration = '',
  });
}
