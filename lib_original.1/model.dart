import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_key.dart';

class Movie {
  final String title, posterPath, overview;

  Movie(this.title, this.posterPath, this.overview);

  Movie.fromJson(Map json)
      : title = json['title'],
        posterPath = json["poster_path"],
        overview = json["overview"];
}

class API {
  final http.Client _client = http.Client();

  static const String _url =
      'https://api.themoviedb.org/3/search/movie?api_key=$api_key&query={1}';

  Future<List<Movie>> get(String query) async {
    List<Movie> list = [];

    var movies = [
      {
        "title": "title1",
        "poster_path": "poster_path1",
        "overview": "overview1",
      },
      {
        "title": "title1",
        "poster_path": "poster_path1",
        "overview": "overview1",
      },
      {
        "title": "title1",
        "poster_path": "poster_path1",
        "overview": "overview1",
      },
    ];
    movies.forEach((movie) => list.add(Movie.fromJson(movie)));

    // await _client
    //     .get(Uri.parse(_url.replaceFirst("{1}", query)))
    //     .then((res) => res.body)
    //     .then(json.decode)
    //     .then((json) => json["results"])
    //     .then((movies) =>
    //         movies.forEach((movie) => list.add(Movie.fromJson(movie))));

    return list;
  }
}
