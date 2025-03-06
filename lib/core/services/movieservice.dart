import 'package:dio/dio.dart';

class MovieService {
  static const String _apiKey =
      "YOUR_TMDB_API_KEY"; // Replace with your actual API key
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static final Dio _dio = Dio();

  // Fetch trending movies
  static Future<List<dynamic>> getTrendingMovies() async {
    try {
      final response = await _dio.get("$_baseUrl/trending/movie/week",
          queryParameters: {"api_key": _apiKey});

      if (response.statusCode == 200) {
        return response.data['results'];
      } else {
        throw Exception("Failed to load movies: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Error fetching movies: $e");
    }
  }
}
