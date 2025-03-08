import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie_magic/core/services/movieservice.dart';
import 'package:movie_magic/models/movie.dart';
import 'package:movie_magic/models/nowplaying.dart';
import 'package:movie_magic/views/home/film.dart';
import 'package:movie_magic/widgets/moviecard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  late final Future<List<NowPlaying>> _nowPlayingMoviesFuture =
      MovieService().fetchNowPlayingMovies();
  late final Future<List<Movie>> _trendingMoviesFuture =
      MovieService().fetchTrendingMovies();
  late final Future<List<Movie>> _upcomingMoviesFuture =
      MovieService().fetchUpcomingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<NowPlaying>>(
              future: _nowPlayingMoviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildShimmerCarousel();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No movies found'));
                }

                final movies = snapshot.data!;

                return Stack(
                  children: [
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        height: 320,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: movies.map((movie) {
                        return Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 320,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor: Colors.grey[800]!,
                                child: Container(
                                  height: 320,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.grey[850],
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 320,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.grey[850],
                                ),
                                child: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 60.0,
                              left: 20.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30.0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Iconsax.star1,
                                          color: Colors.yellow,
                                          size: 16.0,
                                        ),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          movie.voteAverage.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 30),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Container(
                                    height: 30.0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Row(
                                      children: movie.genreIds.map((genreId) {
                                        return Row(
                                          children: [
                                            Text(
                                              _getGenreName(genreId),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                            ),
                                            const VerticalDivider(
                                              color: Colors.white,
                                              thickness: 0.6,
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    Positioned(
                      right: 20.0,
                      bottom: 60.0,
                      child: AnimatedSmoothIndicator(
                        activeIndex: _currentIndex,
                        count: 5,
                        effect: const WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.white,
                        ),
                        onDotClicked: (index) {
                          _controller.animateToPage(index);
                        },
                      ),
                    ),
                    Positioned(
                      right: 20.0,
                      left: 20.0,
                      bottom: 5.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 119, 22, 212),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() =>
                              FilmDetails(movieId: movies[_currentIndex].id));
                        },
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.video_play, color: Colors.white),
                              SizedBox(width: 10.0),
                              Text(
                                "Watch Now",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // Trending Movies Section
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, bottom: 20.0, top: 30.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trending Now',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      CupertinoIcons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Movie>>(
              future: _trendingMoviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildShimmerTrendingMovies();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No movies found'));
                }

                return TrendMovieSection(movies: snapshot.data!);
              },
            ),

            // Upcoming Movies Section
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 10.0, bottom: 20.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upcoming Movies',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      CupertinoIcons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Movie>>(
              future: _upcomingMoviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildShimmerTrendingMovies();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No movies found'));
                }

                return TrendMovieSection(movies: snapshot.data!);
              },
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // Shimmer effect for the carousel
  Widget _buildShimmerCarousel() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[800]!,
      child: Stack(
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey[850],
            ),
          ),
          Positioned(
            bottom: 60.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30.0,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 30.0,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 30.0,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Shimmer effect for the trending/upcoming movies section
  Widget _buildShimmerTrendingMovies() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[800]!,
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              width: 150,
              height: 220,
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[850],
              ),
            );
          },
        ),
      ),
    );
  }

  String _getGenreName(int genreId) {
    switch (genreId) {
      case 28:
        return 'Action';
      case 12:
        return 'Adventure';
      case 16:
        return 'Animation';
      case 35:
        return 'Comedy';
      case 80:
        return 'Crime';
      case 99:
        return 'Documentary';
      case 18:
        return 'Drama';
      case 10751:
        return 'Family';
      case 14:
        return 'Fantasy';
      case 36:
        return 'History';
      case 27:
        return 'Horror';
      case 10402:
        return 'Music';
      case 9648:
        return 'Mystery';
      case 10749:
        return 'Romance';
      case 878:
        return 'Science Fiction';
      case 10770:
        return 'TV Movie';
      case 53:
        return 'Thriller';
      case 10752:
        return 'War';
      case 37:
        return 'Western';
      default:
        return 'Unknown';
    }
  }
}

class TrendMovieSection extends StatelessWidget {
  final List<Movie> movies;

  const TrendMovieSection({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => FilmDetails(movieId: movies[index].id));
                  },
                  child: MovieCard(movie: movies[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
