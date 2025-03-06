import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movie_magic/core/services/movieservice.dart';
import 'package:movie_magic/models/movie.dart';
import 'package:movie_magic/views/home/film.dart';
import 'package:movie_magic/widgets/moviecard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  late Future<List<Movie>> _trendsmoviesFuture;

  final List<String> images = [
    'https://occ-0-8407-116.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABSnpnCU2Bb-QjJmTVcTU6gG57sYTE-q2UOx2GsLEjFX83tNvgxB5yFtpqyJQGAAB21o_O9VYKdOKPfxe7joIcWaMPhrF3YRfNNBP.jpg?r=afe',
    'https://occ-0-8407-116.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABSnpnCU2Bb-QjJmTVcTU6gG57sYTE-q2UOx2GsLEjFX83tNvgxB5yFtpqyJQGAAB21o_O9VYKdOKPfxe7joIcWaMPhrF3YRfNNBP.jpg?r=afe',
    'https://occ-0-8407-116.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABSnpnCU2Bb-QjJmTVcTU6gG57sYTE-q2UOx2GsLEjFX83tNvgxB5yFtpqyJQGAAB21o_O9VYKdOKPfxe7joIcWaMPhrF3YRfNNBP.jpg?r=afe',
    'https://occ-0-8407-116.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABSnpnCU2Bb-QjJmTVcTU6gG57sYTE-q2UOx2GsLEjFX83tNvgxB5yFtpqyJQGAAB21o_O9VYKdOKPfxe7joIcWaMPhrF3YRfNNBP.jpg?r=afe',
  ];

  @override
  void initState() {
    super.initState();
    _trendsmoviesFuture = MovieService().fetchTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                  items: images.map((image) {
                    return Stack(
                      children: [
                        Container(
                          height: 320,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
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
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.star1,
                                      color: Colors.yellow,
                                      size: 16.0,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      "9.5",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Text(
                                "Red Notice",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: 30.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      "Action",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    ),
                                    VerticalDivider(
                                      color: Colors.white,
                                      thickness: 0.6,
                                    ),
                                    Text(
                                      "Adventure",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    ),
                                    VerticalDivider(
                                      color: Colors.white,
                                      thickness: 0.6,
                                    ),
                                    Text(
                                      "Fantasy",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
                Positioned(
                  right: 20.0,
                  bottom: 60.0,
                  child: AnimatedSmoothIndicator(
                    activeIndex: _currentIndex,
                    count: images.length,
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
                      backgroundColor: const Color.fromARGB(255, 119, 22, 212),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {},
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.video_play, color: Colors.white),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Watch Now",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder<List<Movie>>(
              future: _trendsmoviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No movies found'));
                }

                return TrendMovieSection(
                    title: 'Trending Now', movies: snapshot.data!);
              },
            )
          ],
        ),
      ),
    );
  }
}

class TrendMovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const TrendMovieSection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 236, 236, 236),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.arrow_right,
                  color: Color.fromARGB(255, 36, 20, 63),
                  size: 20.0,
                ),
              ),
            ],
          ),
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
                    child: MovieCard(movie: movies[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
