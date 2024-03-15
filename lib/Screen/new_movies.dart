import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviesapp/constant/constants.dart';
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
          backgroundColor: const Color.fromARGB(31, 8, 175, 231),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                // Navigate to the search screen when the search icon is tapped
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MovieSearchScreen(),
                ));
              },
            ),
          ],
          title: const Text(
            'Movie Categories',
            style: TextStyle(color: Colors.black),
          ),
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

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(142, 16, 111, 175)
                .withOpacity(0.7), // Start color
            const Color.fromARGB(174, 49, 154, 141)
                .withOpacity(0.2), // End color
          ],
        ),
      ),
      child: Column(
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
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        child: Container(
                          width: 200,
                          height: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: const Color.fromARGB(255, 11, 93, 164),
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
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
