import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not_net_flix/models/movie.dart';
import 'package:not_net_flix/ui/widgets/movie_card.dart';

class MoviCategory extends StatelessWidget {
  final String label;
  final List<Movie> moviList;
  final double imageHeight;
  final double imageWidth;
  final Function callback;

  const MoviCategory({
    Key? key,
    required this.label,
    required this.moviList,
    required this.imageHeight,
    required this.imageWidth,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(label,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        SizedBox(
          height: imageHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              final currentPosition = notification.metrics.pixels;
              //final minPosition = notification.metrics.minScrollExtent;
              final maxPosition = notification.metrics.maxScrollExtent;
              // ignore: avoid_print
              //print("POSITION COURANT $currentPosition");
              // ignore: avoid_print
              //print("POSITION MINIMUM $minPosition");
              // ignore: avoid_print
              //print("POSITION MAXIMALE $maxPosition");

              if (currentPosition >= maxPosition / 2) {
                callback();
              }
              return true;
            },
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: moviList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: imageWidth,
                    child: moviList.isEmpty
                        ? const Center(
                            child: Text("Api Response is empty"),
                          )
                        : MoviCard(internalMovie: moviList[index]),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
