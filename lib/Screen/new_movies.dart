import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviesapp/Constant.dart/constants.dart';
import 'package:moviesapp/Screen/search_screen.dart';
import 'package:moviesapp/Screen/new_movies_description.dart';
import 'package:moviesapp/model/movie_model.dart';
import 'package:moviesapp/provider/movies_provider.dart';

class ApiDataFetch extends StatelessWidget {
  const ApiDataFetch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Navigate to the search screen when the search icon is tapped
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MovieSearchScreen(),
                ));
              },
            ),
          ],
          title: const Text('Movie Categories'),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              CategoryWidget(title: 'Now Playing'),
              CategoryWidget(title: 'Top rated'),
              CategoryWidget(title: 'Popular'),
              // Add CategoryWidget for 'Upcoming' here
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryWidget extends ConsumerWidget {
  final String title;

  const CategoryWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryMoviesAsyncValue = ref.watch(categoryMoviesProvider(title));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 300,
          child: categoryMoviesAsyncValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text('Error: $error'),
            data: (movies) {
              if (movies.isEmpty) {
                return const Text('No data available');
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  Movie movie = movies[index];

                  return GestureDetector(
                    onTap: () {
                      // Navigate to MovieDetailsScreen on tap
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailsScreen(movie: movie),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: const Color.fromARGB(255, 75, 102, 125),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Image.network(
                                  '${Constants.imagepath}${movie.posterPath ?? ''}',
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Text(
                                    movie.releaseDate ??
                                        'No release date available',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
