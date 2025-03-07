import 'package:dio/dio.dart';
import 'package:movie_magic/core/utils/constants.dart';
import 'package:movie_magic/models/actor.dart';
import 'package:movie_magic/models/cast.dart';
import 'package:movie_magic/models/filmography.dart';
import 'package:movie_magic/models/movie.dart';
import 'package:movie_magic/models/nowplaying.dart';
import 'package:movie_magic/models/reviews.dart';

class MovieService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: {
        'Authorization': 'Bearer ${Constants.bearerToken}',
        'accept': 'application/json',
      },
    ),
  );

  Future<List<Movie>> fetchTrendingMovies() async {
    try {
      final response = await _dio.get(Constants.trendingMoviesEndpoint);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load trending movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    try {
      final response = await _dio.get(Constants.upcomingMoviesEndpoint);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load trending movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  //Movie Images
  Future<List<String>> fetchMovieImages(int movieId) async {
    try {
      final response = await _dio.get(
        Constants.movieImagesEndpoint
            .replaceAll('{movie_id}', movieId.toString()),
      );
      if (response.statusCode == 200) {
        List<dynamic> backdrops = response.data['backdrops'];
        return backdrops
            .map((json) => json['file_path'])
            .toList()
            .cast<String>();
      } else {
        throw Exception('Failed to load movie images');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<String>> fetchActorImages(int actorId) async {
    try {
      final response = await _dio.get(
        '${Constants.baseUrl}${Constants.actorImagesEndpoint}'
            .replaceAll('{person_id}', actorId.toString()),
      );
      if (response.statusCode == 200) {
        List<dynamic> profiles = response.data['profiles'];
        return profiles.map((json) => json['file_path'] as String).toList();
      } else {
        throw Exception('Failed to load actor images');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<ActorDetails> fetchActorDetails(int actorId) async {
    try {
      final response = await _dio.get(
        '${Constants.baseUrl}${Constants.actorDetailsEndpoint}'
            .replaceAll('{person_id}', actorId.toString()),
      );

      if (response.statusCode == 200) {
        return ActorDetails.fromJson(response.data);
      } else {
        throw Exception('Failed to load actor details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Filmography>> fetchActorMovieCredits(int actorId) async {
    try {
      final response = await _dio.get(
        '${Constants.baseUrl}${Constants.actorMovieCreditsEndpoint}'
            .replaceAll('{person_id}', actorId.toString()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> castList = response.data['cast'];
        return castList.map((json) => Filmography.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load actor movie credits');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<NowPlaying>> fetchNowPlayingMovies() async {
    try {
      final response = await _dio.get(Constants.trendingMoviesEndpoint);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => NowPlaying.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Now Playing Movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  //Movie Details
  Future<Movie> fetchMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        Constants.movieDetailsEndpoint
            .replaceAll('{movie_id}', movieId.toString()),
      );
      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  //Similar Movies
  Future<List<Movie>> fetchSimilarMovies(int movieId) async {
    try {
      final response = await _dio.get(
        Constants.similarMoviesEndpoint
            .replaceAll('{movie_id}', movieId.toString()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load similar movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  //cast and crew
  Future<List<Cast>> fetchMovieCast(int movieId) async {
    try {
      final response = await _dio.get(
        Constants.castCrewEndpoint.replaceAll('{movie_id}', movieId.toString()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> castList = response.data['cast'];
        return castList.map((json) => Cast.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movie cast');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Review>> fetchMovieReviews(int movieId) async {
    try {
      final response = await _dio.get(
        Constants.movieReviewsEndpoint
            .replaceAll('{movie_id}', movieId.toString()),
      );
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => Review.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movie reviews');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
