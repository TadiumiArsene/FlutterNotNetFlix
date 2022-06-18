import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:not_net_flix/models/movie.dart';

import '../screens/movie_details_page.dart';

class MoviCard extends StatelessWidget {
  final Movie internalMovie;
  const MoviCard({Key? key, required this.internalMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MovieDetailsPage(movie: internalMovie);
            },
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: internalMovie.getPosterURL(),
        fit: BoxFit.cover,
        errorWidget: (context, url, erro) => const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
