import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:not_net_flix/models/movie.dart';
import 'package:not_net_flix/repositories/data_repository.dart';
import 'package:not_net_flix/ui/widgets/movie_action_button.dart';
import 'package:not_net_flix/ui/widgets/movie_infos.dart';
import 'package:not_net_flix/utils/constante.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_video_player.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;
  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
      ),
      body: newMovie == null
          ? Center(
              child: SpinKitFadingCircle(
                color: kPrimaryColor,
                size: 25,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: VideoPlayer(movieID: newMovie!.videos!.first),
                  ),
                  MovieInfo(movie: newMovie!),
                  const SizedBox(
                    height: 5,
                  ),
                  ActionButton(
                    label: 'Lecture',
                    icon: Icons.play_arrow,
                    bgColor: Colors.white,
                    forColor: kBackgroundColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    label: 'Télécharger la vidéo',
                    icon: Icons.download,
                    bgColor: Colors.grey.withOpacity(0.3),
                    forColor: Colors.white,
                  ),
                ],
              ),
            ),
    );
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    Movie movie = await dataProvider.getMovieDetails(paramMovie: widget.movie);
    setState(() {
      newMovie = movie;
    });
  }
}
