import 'package:dio/dio.dart';
import 'package:not_net_flix/models/person.dart';
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
      List<String> videosKeys =
          data['results'].map<String>((dynamic videoJson) {
        return videoJson['key'] as String;
      }).toList();
      return movie.copyWith(videos: videosKeys);
    } else {
      throw response;
    }
  }

  Future<Movie> fetchMovieCast({required Movie movie}) async {
    Response response = await fetchData('3/movie/${movie.id}/credits');
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Person> casting = data['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();
      return movie.copyWith(casting: casting);
    } else {
      throw response;
    }
  }

  Future<Movie> fetchMovieImages({required Movie movie}) async {
    Response response = await fetchData('3/movie/${movie.id}/images', params: {
      'include_image_language': 'null',
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      List<String> imagePath =
          data['backdrops'].map<String>((dynamic imageJson) {
        return imageJson['file_path'] as String;
      }).toList();
      return movie.copyWith(
        images: imagePath,
      );
    } else {
      throw response;
    }
  }

  Future<Movie> fetchMovie({required Movie movie}) async {
    Response response = await fetchData('3/movie/${movie.id}', params: {
      'include_image_language': 'null',
      'append_to_response': 'videos,images,credits'
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      //on récupère les genres
      var genre = data["genres"] as List;
      // ignore: no_leading_underscores_for_local_identifiers
      List<String> _genres =
          genre.map((item) => item["name"] as String).toList();

      //on récupère les videos
      // ignore: no_leading_underscores_for_local_identifiers
      List<String> _videos = data['videos']['results']
          .map<String>((dynamic videoJson) => videoJson['key'] as String)
          .toList();

      //on récupère les castings
      // ignore: no_leading_underscores_for_local_identifiers
      List<Person> _castings = data['credits']['cast']
          .map<Person>((dynamic castJson) => Person.fromJson(castJson))
          .toList();

      //on récupère les images
      // ignore: no_leading_underscores_for_local_identifiers
      List<String> _images = data['images']['backdrops']
          .map<String>((dynamic imageJson) => imageJson['file_path'] as String)
          .toList();

      //on retourne l'objet avec tout dedans
      return movie.copyWith(
        genres: _genres,
        videos: _videos,
        casting: _castings,
        images: _images,
        releaseDate: data["release_date"],
        vote: data["vote_average"],
      );
    } else {
      throw response;
    }
  }
}
