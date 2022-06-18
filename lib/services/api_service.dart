import 'package:dio/dio.dart';
import 'package:not_net_flix/services/api.dart';
import '../models/movie.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> fetchData(String path,
      {Map<String, dynamic>? params}) async {
    //je construit l'url de la requete
    String url = api.baseURL + path;

    //je construit les parametres de la requete
    //ces parametres seront communes a toutes les requetes
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR',
    };

    //ajout des parametres si ma requete en possede
    if (params != null) {
      query.addAll(params);
    }

    //je construit la requete
    final response = await dio.get(url, queryParameters: query);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> fetchPopularMovies({required int pageIndex}) async {
    Response response = await fetchData('3/movie/popular', params: {
      'page': pageIndex,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> result = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in result) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> fetchNowPlaying({required int pageIndex}) async {
    Response response = await fetchData('3/movie/now_playing', params: {
      'page': pageIndex,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      // ignore: non_constant_identifier_names
      List<Movie> myPlayingMovies =
          data['results'].map<Movie>((dynamic playingJson) {
        return Movie.fromJson(playingJson);
      }).toList();
      return myPlayingMovies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> fetchUpComingMovies({required int pageIndex}) async {
    Response response = await fetchData('3/movie/upcoming', params: {
      'page': pageIndex,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      // ignore: non_constant_identifier_names
      List<Movie> myComingMovies =
          data['results'].map<Movie>((dynamic comingJson) {
        return Movie.fromJson(comingJson);
      }).toList();
      return myComingMovies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> fetchAnimationMovies({required int pageIndex}) async {
    Response response = await fetchData('3/discover/movie',
        params: {'page': pageIndex, 'with_genres': '16'});

    if (response.statusCode == 200) {
      Map data = response.data;
      // ignore: non_constant_identifier_names
      List<Movie> myAnimationMovies =
          data['results'].map<Movie>((dynamic comingJson) {
        return Movie.fromJson(comingJson);
      }).toList();
      return myAnimationMovies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> fetchAventureMovies({required int pageIndex}) async {
    Response response = await fetchData('3/discover/movie',
        params: {'page': pageIndex, 'with_genres': '12'});

    if (response.statusCode == 200) {
      Map data = response.data;
      // ignore: non_constant_identifier_names
      List<Movie> myAventureMovies =
          data['results'].map<Movie>((dynamic aventureJson) {
        return Movie.fromJson(aventureJson);
      }).toList();
      return myAventureMovies;
    } else {
      throw response;
    }
  }

  Future<Movie> fetchMovieDetails({required Movie movie}) async {
    Response response = await fetchData('3/movie/${movie.id}');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      var genre = data["genres"] as List;
      List<String> genreList =
          genre.map((item) => item["name"] as String).toList();
      Movie newMovie = movie.copyWith(
        genres: genreList,
        releaseDate: data["release_date"],
        vote: data["vote_average"],
      );
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> fetchMovieVideos({required Movie movie}) async {
    Response response = await fetchData('3/movie/${movie.id}/videos');

    if (response.statusCode == 200) {
      Map data = response.data;
      List<String> videosKey = data['results'].map<String>((dynamic videoJson) {
        return videoJson['key'] as String;
      }).toList();
      return movie.copyWith(videos: videosKey);
    } else {
      throw response;
    }
  }
}
