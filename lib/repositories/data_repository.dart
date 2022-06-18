//import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:not_net_flix/models/movie.dart';
import 'package:not_net_flix/services/api_service.dart';

class DataRepository with ChangeNotifier {
  //Definition Propriétés
  final APIService apiService = APIService();

  final List<Movie> _popularMovieList = [];
  int _pageIndex = 1;

  final List<Movie> _nowPlaying = [];
  int _nowPlayingPageIndex = 1;

  final List<Movie> _upComing = [];
  int _upComingPageIndex = 1;

  final List<Movie> _animationMovie = [];
  int _animationPageIndex = 1;

  final List<Movie> _aventureMovie = [];
  int _aventurePageIndex = 1;

  //Definition Getters
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlaying => _nowPlaying;
  List<Movie> get upComong => _upComing;
  List<Movie> get animationMovies => _animationMovie;
  List<Movie> get aventureMovies => _aventureMovie;

  //Definition fonction renvoie populaire movies
  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies =
          await apiService.fetchPopularMovies(pageIndex: _pageIndex);
      _popularMovieList.addAll(movies);
      _pageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR : ${response.statusCode}");
      rethrow;
    }
  }

  //Definition fonction renvoie now playing movies
  Future<void> getNowPlaying() async {
    try {
      List<Movie> nowMovies =
          await apiService.fetchNowPlaying(pageIndex: _nowPlayingPageIndex);
      _nowPlaying.addAll(nowMovies);
      _nowPlayingPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR : ${response.statusCode}");
      rethrow;
    }
  }

  //Definition fonction renvoie coming-up movies
  Future<void> getUpComingMovies() async {
    try {
      List<Movie> upComingMovies =
          await apiService.fetchNowPlaying(pageIndex: _upComingPageIndex);
      _upComing.addAll(upComingMovies);
      _upComingPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR : ${response.statusCode}");
      rethrow;
    }
  }

  //Definition fonction renvoie animation movies
  Future<void> getAnimationMovies() async {
    try {
      List<Movie> animations =
          await apiService.fetchAnimationMovies(pageIndex: _animationPageIndex);
      _animationMovie.addAll(animations);
      _animationPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR : ${response.statusCode}");
      rethrow;
    }
  }

  //Definition fonction renvoie aventure movies
  Future<void> getAventureMovies() async {
    try {
      List<Movie> aventures =
          await apiService.fetchAventureMovies(pageIndex: _aventurePageIndex);
      _aventureMovie.addAll(aventures);
      _aventurePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR : ${response.statusCode}");
      rethrow;
    }
  }

  //Definition fonction renvoie movie details
  Future<Movie> getMovieDetails({required Movie paramMovie}) async {
    try {
      //ici on recupère les info du film
      Movie newMovie = await apiService.fetchMovieDetails(movie: paramMovie);
      //ici on recupère la video relative au film
      newMovie = await apiService.fetchMovieVideos(movie: newMovie);
      return newMovie;
    } on Response catch (response) {
      // ignore: avoid_print
      print("ERROR : ${response.statusCode}");
      rethrow;
    }
  }

  //Definition fonction initialisation appels Apis
  Future<void> initData() async {
    //Execution en Linaire ou Synchrone
    // await getPopularMovies();
    // await getNowPlaying();
    // await getUpComingMovies();
    // await getAnimationMovies();
    // await getAventureMovies();

    //Execution Paralelle ou Asynchrone
    await Future.wait([
      getPopularMovies(),
      getNowPlaying(),
      getUpComingMovies(),
      getAnimationMovies(),
      getAventureMovies(),
    ]);
  }
}
