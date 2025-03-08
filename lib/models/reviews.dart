class Review {
  final String username;
  final double rating;
  final String date;
  final String content;

  Review({
    required this.username,
    required this.rating,
    required this.date,
    required this.content,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      username: json['author_details']['username'] ?? 'Unknown',
      rating: (json['author_details']['rating'] as num?)?.toDouble() ?? 0.0,
      date: json['created_at'] != null
          ? json['created_at'].toString().substring(0, 10)
          : '',
      content: json['content'] ?? '',
    );
  }
}
