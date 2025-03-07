class Filmography {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String character;
  final String department;

  Filmography({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.character,
    required this.department,
  });

  factory Filmography.fromJson(Map<String, dynamic> json) {
    return Filmography(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      character: json['character'] ?? '',
      department: json['known_for_department'] ?? 'Acting',
    );
  }
}
