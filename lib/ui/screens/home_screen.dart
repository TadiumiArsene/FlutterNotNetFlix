import 'package:flutter/material.dart';
import 'package:not_net_flix/repositories/data_repository.dart';
import 'package:not_net_flix/ui/widgets/movie_card.dart';
import 'package:not_net_flix/utils/constante.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_categori.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: MoviCard(internalMovie: dataProvider.popularMovieList.first),
          ),
          //=============Zone Tendances Actuelles ================//
          MoviCategory(
            imageHeight: 160,
            imageWidth: 110,
            label: 'Tendances Actuelles',
            moviList: dataProvider.popularMovieList,
            callback: dataProvider.getPopularMovies,
          ),
          //=============Actuelles au Cinema ================//
          MoviCategory(
            imageHeight: 320,
            imageWidth: 220,
            label: 'Actuellement au cinéma',
            moviList: dataProvider.nowPlaying,
            callback: dataProvider.getNowPlaying,
          ),
          //=============bientot au Cinema ================//
          MoviCategory(
            imageHeight: 160,
            imageWidth: 110,
            label: 'Ils arrivent bientot',
            moviList: dataProvider.upComong,
            callback: dataProvider.getUpComingMovies,
          ),
          //============= animation au Cinema ================//
          MoviCategory(
            imageHeight: 320,
            imageWidth: 220,
            label: 'Animations',
            moviList: dataProvider.animationMovies,
            callback: dataProvider.getAnimationMovies,
          ),
          //============= filme d'aventure au Cinema ================//
          MoviCategory(
            imageHeight: 320,
            imageWidth: 220,
            label: 'Aventures',
            moviList: dataProvider.aventureMovies,
            callback: dataProvider.getAventureMovies,
          )
          //==============================================//
        ],
      ),
    );
  }
}
