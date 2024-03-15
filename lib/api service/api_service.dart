import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapp/Constant.dart/constants.dart';
import 'package:moviesapp/model/movie_model.dart';

final apiProvider = Provider<Api>((ref) {
  return Api();
});

class Api {
  static String dataquery = '';
  static const nowPlaying =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apikey}';
  static const popular =
      'https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apikey}';
  static const topRated =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apikey}';

  Future<List<Movie>> getNowplayingMovies() async {
    final response = await http.get(Uri.parse(nowPlaying));

    if (response.statusCode == 200) {
      var playingData = json.decode(response.body)['results'] as List;

      return playingData.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> getpopularMovies() async {
    final response = await http.get(Uri.parse(popular));

    if (response.statusCode == 200) {
      var popularData = json.decode(response.body)['results'] as List;

      return popularData.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> getTopRated() async {
    final response = await http.get(Uri.parse(topRated));

    if (response.statusCode == 200) {
      var topRatedData = json.decode(response.body)['results'] as List;

      return topRatedData.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> getSreachedMovie(String moviename) async {
    final search =
        'https://api.themoviedb.org/3/search/movie?api_key=${Constants.searchapikey}&query=$moviename';

    final response = await http.get(Uri.parse(search));

    if (response.statusCode == 200) {
      var searchedmovies = json.decode(response.body)['results'] as List;
      return searchedmovies.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Not found ');
    }
  }
}
