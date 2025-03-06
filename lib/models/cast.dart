class Cast {
  final int id;
  final String originalName;
  final String knownForDepartment;
  final String profilePath;

  Cast({
    required this.originalName,
    required this.knownForDepartment,
    required this.profilePath,
    required this.id,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'],
      originalName: json['original_name'],
      knownForDepartment: json['known_for_department'],
      profilePath: json['profile_path'] ?? '',
    );
  }
}
