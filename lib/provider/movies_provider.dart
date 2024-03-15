import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviesapp/api%20service/api_service.dart';
import 'package:moviesapp/model/movie_model.dart';

final categoryMoviesProvider =
    FutureProvider.family<List<Movie>, String>((ref, categoryTitle) async {
  final apiService = ref.read(apiProvider);

  switch (categoryTitle.toLowerCase()) {
    case 'now playing':
      return apiService.getNowplayingMovies();
    case 'top rated':
      return apiService.getTopRated();
    case 'popular':
      return apiService.getpopularMovies();
    // Add cases for other categories

    default:
      throw Exception('Invalid category title: $categoryTitle');
  }
});

final searchedMoviesProvider =
    FutureProvider.family<List<Movie>, String>((ref, movietitle) async {
  final apiSearchservice = ref.read(apiProvider);

  return apiSearchservice.getSreachedMovie(movietitle);
});

final searchQueryProvider = StateProvider<String>((ref) => '');
