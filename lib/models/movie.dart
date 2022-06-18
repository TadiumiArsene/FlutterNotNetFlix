import 'package:not_net_flix/services/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;
  final List<String>? genres;
  final String? releaseDate;
  final double? vote;

  Movie(
      {required this.id,
      required this.name,
      required this.description,
      this.posterPath,
      this.genres,
      this.releaseDate,
      this.vote});

  Movie copyWith(
      {int? id,
      String? name,
      String? description,
      String? posterPath,
      List<String>? genres,
      String? releaseDate,
      double? vote}) {
    return Movie(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        posterPath: posterPath ?? this.posterPath,
        genres: genres ?? this.genres,
        releaseDate: releaseDate ?? this.releaseDate,
        vote: vote ?? this.vote);
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['title'],
      description: map['overview'],
      posterPath: map['poster_path'],
    );
  }

  String getPosterURL() {
    API api = API();
    return api.baseImageURL + posterPath!;
  }

  String reformatGenres() {
    String categories = '';
    for (var i = 0; i < genres!.length; i++) {
      if (i == genres!.length - 1) {
        categories += genres![i];
      } else {
        categories += '${genres![i]}, ';
      }
    }
    return categories;
  }

  @override
  String toString() {
    return 'Movie(id: $id, name: $name, description: $description, posterPath: $posterPath)';
  }
}
