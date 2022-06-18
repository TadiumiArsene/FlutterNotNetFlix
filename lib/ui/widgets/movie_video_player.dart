import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:not_net_flix/utils/constante.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String movieID;
  const VideoPlayer({Key? key, required this.movieID}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController? controlleur;

  @override
  void initState() {
    super.initState();
    controlleur = YoutubePlayerController(
      initialVideoId: widget.movieID,
      flags: const YoutubePlayerFlags(
          mute: false, autoPlay: false, hideThumbnail: true),
    );
  }

  @override
  void dispose() {
    controlleur!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controlleur == null
        ? Center(
            child: SpinKitFadingCircle(
              color: kPrimaryColor,
              size: 20,
            ),
          )
        : YoutubePlayer(controller: controlleur!);
  }
}
