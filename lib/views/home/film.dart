import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie_magic/core/services/movieservice.dart';
import 'package:movie_magic/models/cast.dart';
import 'package:movie_magic/models/movie.dart';
import 'package:movie_magic/models/reviews.dart';
import 'package:movie_magic/views/home/actor.dart';
import 'package:movie_magic/views/home/home.dart';
import 'package:movie_magic/widgets/moviecard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FilmDetails extends StatefulWidget {
  final int movieId;
  const FilmDetails({super.key, required this.movieId});

  @override
  State<FilmDetails> createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  late final Future<List<Movie>> _similarMovies =
      MovieService().fetchSimilarMovies(widget.movieId);
  late final Future<List<String>> images =
      MovieService().fetchMovieImages(widget.movieId);
  late final Future<Movie> _movieDetailsFuture =
      MovieService().fetchMovieDetails(widget.movieId);
  late final Future<List<Cast>> _castFuture =
      MovieService().fetchMovieCast(widget.movieId);
  late final Future<List<Review>> _reviewsFuture =
      MovieService().fetchMovieReviews(widget.movieId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Section
            FutureBuilder<List<String>>(
              future: images,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      width: double.infinity,
                      height: 320,
                      decoration: BoxDecoration(
                        color: Colors.grey[850]!,
                        borderRadius:
                            BorderRadius.circular(20.0), // Border radius
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No images found'));
                }

                final imageUrls = snapshot.data!;

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
                      items: imageUrls.map((imageUrl) {
                        return Container(
                          height: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w780$imageUrl'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Positioned(
                      top: 30.0,
                      left: 20.0,
                      child: GestureDetector(
                        onTap: () {
                          Get.offAll(() => const Home());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.back,
                                color: Colors.white,
                                size: 22.0,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                      bottom: 60.0,
                      left: 20.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Iconsax.star1,
                                  color: Colors.yellow,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 5.0),
                                FutureBuilder<Movie>(
                                  future: _movieDetailsFuture,
                                  builder: (context, movieSnapshot) {
                                    if (movieSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text(
                                        "Loading...",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      );
                                    } else if (movieSnapshot.hasError) {
                                      return Text(
                                        'Error: ${movieSnapshot.error}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      );
                                    } else if (!movieSnapshot.hasData) {
                                      return const Text(
                                        'No data',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      );
                                    }

                                    final movie = movieSnapshot.data!;

                                    return Text(
                                      "${movie.voteAverage}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    );
                                  },
                                ),
                                const VerticalDivider(
                                  color: Colors.white,
                                  thickness: 0.6,
                                ),
                                FutureBuilder<Movie>(
                                  future: _movieDetailsFuture,
                                  builder: (context, movieSnapshot) {
                                    if (movieSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text(
                                        "Loading...",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      );
                                    } else if (movieSnapshot.hasError) {
                                      return Text(
                                        'Error: ${movieSnapshot.error}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      );
                                    } else if (!movieSnapshot.hasData) {
                                      return const Text(
                                        'No data',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      );
                                    }

                                    final movie = movieSnapshot.data!;

                                    return Text(
                                      movie.releaseDate.substring(0, 4), // Year
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    );
                                  },
                                ),
                                const VerticalDivider(
                                  color: Colors.white,
                                  thickness: 0.6,
                                ),
                                const Text(
                                  "+12",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20.0,
                      left: 20.0,
                      bottom: 5.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 119, 22, 212),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Iconsax.play, color: Colors.white),
                                    SizedBox(width: 10.0),
                                    Text(
                                      "Watch Now",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 240, 240, 240),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.video_play,
                                      color: Color.fromARGB(255, 119, 22, 212),
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      "Watch Trailer",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 119, 22, 212),
                                          fontSize: 16.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            // Movie Details Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Genres and Runtime
                  FutureBuilder<Movie>(
                    future: _movieDetailsFuture,
                    builder: (context, movieSnapshot) {
                      if (movieSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: Container(
                            width: double.infinity,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius:
                                  BorderRadius.circular(10.0), // Border radius
                            ),
                          ),
                        );
                      } else if (movieSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${movieSnapshot.error}'));
                      } else if (!movieSnapshot.hasData) {
                        return const Center(
                            child: Text('No movie details found'));
                      }

                      final movie = movieSnapshot.data!;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              for (var genre in movie.genres)
                                Row(
                                  children: [
                                    Text(genre,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text(". ",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          // Runtime
                          Text(
                            "${movie.runtime ~/ 60}h ${movie.runtime % 60}m",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),

                  // Title & Overview
                  FutureBuilder<Movie>(
                    future: _movieDetailsFuture,
                    builder: (context, movieSnapshot) {
                      if (movieSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: Container(
                            width: double.infinity,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius:
                                  BorderRadius.circular(10.0), // Border radius
                            ),
                          ),
                        );
                      } else if (movieSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${movieSnapshot.error}'));
                      } else if (!movieSnapshot.hasData) {
                        return const Center(
                            child: Text('No movie details found'));
                      }

                      final movie = movieSnapshot.data!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              movie.overview,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 30.0),

                  // Interaction Buttons
                  FutureBuilder<Movie>(
                    future: _movieDetailsFuture,
                    builder: (context, movieSnapshot) {
                      if (movieSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius:
                                  BorderRadius.circular(20.0), // Border radius
                            ),
                          ),
                        );
                      } else if (movieSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${movieSnapshot.error}'));
                      } else if (!movieSnapshot.hasData) {
                        return const Center(
                            child: Text('No movie details found'));
                      }

                      final movie = movieSnapshot.data!;

                      return Row(
                        children: [
                          // Likes and Dislikes
                          Container(
                            height: 40.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 45, 36, 58),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.thumb_up_outlined,
                                  size: 20.0,
                                  color: Color.fromARGB(160, 255, 255, 255),
                                ),
                                const SizedBox(width: 5.0),
                                Text("${movie.voteCount}"),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: VerticalDivider(
                                    color: Colors.white,
                                    thickness: 0.6,
                                  ),
                                ),
                                const Icon(
                                  Icons.thumb_down_outlined,
                                  size: 20.0,
                                  color: Color.fromARGB(160, 255, 255, 255),
                                ),
                                const SizedBox(width: 5.0),
                                Text("${movie.voteCount}"),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.bookmark_border),
                            onPressed: () {},
                            style: IconButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 45, 36, 58),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.share),
                            onPressed: () {},
                            style: IconButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 45, 36, 58),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.download_rounded),
                            onPressed: () {},
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xFF6200EE),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // Cast & Crew (if applicable)
                  const SizedBox(height: 30.0),
                  const Text(
                    "Cast & Crew",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  FutureBuilder<List<Cast>>(
                      future: _castFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SizedBox(
                              height: 150.0,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Column(
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[850]!,
                                            highlightColor: Colors.grey[800]!,
                                            child: Container(
                                              height: 80.0,
                                              width: 80.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey[850],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No cast details found'));
                        }

                        final castList = snapshot.data!;

                        return SizedBox(
                          height: 150.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: castList.length,
                            itemBuilder: (context, index) {
                              final cast = castList[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Open Cast Details
                                        Get.to(() =>
                                            ActorProfile(actorId: cast.id));
                                      },
                                      child: Container(
                                        height: 80.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${cast.profilePath}',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      cast.knownForDepartment,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 202, 202, 202)),
                                    ),
                                    Text(
                                      cast.originalName,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),

                  const SizedBox(height: 20.0),
                  const Text(
                    "Audio Track & Subtitle",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  FutureBuilder<Movie>(
                    future: _movieDetailsFuture,
                    builder: (context, movieSnapshot) {
                      if (movieSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius:
                                  BorderRadius.circular(20.0), // Border radius
                            ),
                          ),
                        );
                      } else if (movieSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${movieSnapshot.error}'));
                      } else if (!movieSnapshot.hasData) {
                        return const Center(
                            child: Text('No movie details found'));
                      }

                      final movie = movieSnapshot.data!;

                      final spokenLanguages = movie.spokenLanguages;

                      return Column(
                        children: [
                          // Audio Track Section
                          Container(
                            height: 40.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 45, 36, 58),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.volume_up,
                                    color: Colors.white, size: 16.0),
                                const SizedBox(width: 8.0),
                                Text(
                                  spokenLanguages.isNotEmpty
                                      ? spokenLanguages[0]
                                          .englishName // Display the first language
                                      : "N/A",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          // Subtitle Section
                          Container(
                            height: 40.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 45, 36, 58),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.subtitles,
                                    color: Colors.white, size: 16.0),
                                const SizedBox(width: 8.0),
                                Text(
                                  spokenLanguages.isNotEmpty
                                      ? spokenLanguages
                                          .map((lang) => lang.englishName)
                                          .join(", ") // Display all languages
                                      : "N/A",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40.0),
                  FutureBuilder<List<Review>>(
                    future: _reviewsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No reviews found'));
                      }

                      return ReviewsSection(reviews: snapshot.data!);
                    },
                  ),
                  // Related Movies
                  const SizedBox(height: 20.0),
                  const Text(
                    "Related Movies",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  FutureBuilder<List<Movie>>(
                    future: _similarMovies,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No movies found'));
                      }

                      return RelatedMovies(movies: snapshot.data!);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RelatedMovies extends StatelessWidget {
  final List<Movie> movies;

  const RelatedMovies({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Get.offAll(() => FilmDetails(movieId: movies[index].id));
                },
                child: MovieCard(movie: movies[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ReviewsSection extends StatefulWidget {
  final List<Review> reviews;

  const ReviewsSection({
    super.key,
    required this.reviews,
  });

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final Map<int, bool> _expandedStates = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reviews",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text("All Reviews",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.reviews.length,
          itemBuilder: (context, index) {
            final review = widget.reviews[index];
            final isExpanded = _expandedStates[index] ?? false;

            return Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 45, 36, 58),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        review.username,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10.0),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16.0,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        review.rating.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    review.date,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 12.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    review.content,
                    style: const TextStyle(color: Colors.white),
                    maxLines: isExpanded ? null : 3,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                  if (review.content.length > 100)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _expandedStates[index] = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? "Read Less" : "Read More",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
