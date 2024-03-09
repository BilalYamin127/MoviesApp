import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviesapp/model/movie.dart';

class LiveMoviesNotifier extends StateNotifier<List<Movie>> {
  LiveMoviesNotifier() : super([]);

  List<Movie> getLiveMovies() {
    return state.where((movie) => movie.category == Category.live).toList();
  }
}

final liveMoviesprovider =
    StateNotifierProvider<LiveMoviesNotifier, List<Movie>>((ref) {
  return LiveMoviesNotifier();
});
