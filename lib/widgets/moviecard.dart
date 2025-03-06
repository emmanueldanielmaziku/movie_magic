import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_magic/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      color: Colors.grey[200],
      margin: const EdgeInsets.only(right: 12),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            movie.imageUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 10,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Center(
                child: Icon(CupertinoIcons.bookmark_solid),
              ),
            )),
      ]),
    );
  }
}
