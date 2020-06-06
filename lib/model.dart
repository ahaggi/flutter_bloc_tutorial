import 'dart:async';

class Movie {
  final String title, posterPath, overview;

  Movie(this.title, this.posterPath, this.overview);

  Movie.fromJson(Map json)
      : title = json['title'],
        posterPath = json["poster_path"],
        overview = json["overview"];
}

class API {

  Future<List<Movie>> get(String query) async {
    await Future.delayed(const Duration(seconds: 5));

    List<Movie> list = [];

    var movies = List.generate(
      3,
      (ind) => {
            "title": "title${ind + 1} $query",
            "poster_path": "poster_path${ind + 1}",
            "overview": "overview${ind + 1} $query",
          },
    );

    if (query.isEmpty) return null;

    movies.forEach((movie) => list.add(Movie.fromJson(movie)));

    return list;
  }
}
