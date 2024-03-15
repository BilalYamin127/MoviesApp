// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviesapp/Constant.dart/constants.dart';

import 'package:moviesapp/provider/movies_provider.dart'; // Adjust the import path as necessary

class MovieSearchScreen extends ConsumerStatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends ConsumerState<MovieSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // void _searchMovies() {
  //   setState(() {}); // Force rebuild to reflect the new state
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter movie title',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text('Search'),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, _) {
                    final movieTitle = _searchController.text;
                    final searchResult = movieTitle.isNotEmpty
                        ? ref.watch(searchedMoviesProvider(movieTitle))
                        : null;

                    return searchResult == null
                        ? const Center(child: Text("Search for movies"))
                        : searchResult.when(
                            data: (movies) => ListView.builder(
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Image.network(
                                          '${Constants.imagepath}${movie.posterPath ?? ''}',
                                          height: 300,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          left: 10,
                                          bottom: 10,
                                          right: 10,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  movie.title ??
                                                      'title not Found',
                                                  style: const TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '★  ${movie.voteAverage}',
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white)), // Example rating
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                );
                              },
                            ),
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stack) =>
                                Center(child: Text('Error: $error')),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
