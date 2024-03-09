import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviesapp/model/movie.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:moviesapp/provider/lives_movies_provider.dart';

class MoviesDetailsScreen extends ConsumerStatefulWidget {
  const MoviesDetailsScreen({super.key, required this.selectedMovie});

  final Movie selectedMovie;
  @override
  ConsumerState<MoviesDetailsScreen> createState() =>
      _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends ConsumerState<MoviesDetailsScreen> {
  bool _showAllLiveMovies = false;

  @override
  Widget build(BuildContext context) {
    final Movie movie = widget.selectedMovie;
    final lm = ref.watch(liveMoviesprovider.notifier).getLiveMovies();
    final List<Movie> liveMovies =
        _showAllLiveMovies ? lm : lm.take(2).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Details',
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    movie.movieimageurl,
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
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('★ + ${movie.rewies}',
                                  style: const TextStyle(
                                      color: Colors.white)), // Example rating
                              ElevatedButton(
                                onPressed: () {
                                  // Follow button action
                                },
                                child: const Text('Follow'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          right: BorderSide(color: Colors.white38),
                        )),
                        child: Text(
                          'Views: ${movie.views}    ',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )), // Example views
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                        color: Colors.white38,
                      ))),
                      child: Text(
                        ' Title: ${movie.title}  ',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Text('Title: ${movie.title}'),
                    Text(
                      'Duration: ${movie.duration}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.all(8.0), // Add padding around the text
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                        height:
                            8), // Add some space between the label and the description
                    ExpandableText(
                      '${movie.description}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      expandText: 'Read More',
                      linkColor: const Color.fromARGB(255, 35, 134, 44),
                      collapseText: 'Read Less',
                      maxLines: 4,
                      linkEllipsis: true,
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  const Text(
                    'Lives',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showAllLiveMovies = !_showAllLiveMovies;
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black)),
                    child: Text(
                      _showAllLiveMovies ? '< See Less' : 'See All >',
                      style: const TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),

              // Example list of live movies (This could be a ListView.builder for dynamic content)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity, // Adjust based on content
                    child: ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // Set scroll direction to horizontal

                      itemCount: liveMovies.length,
                      itemBuilder: (context, index) {
                        final liveMovie = liveMovies[index];
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23)),
                          child: Stack(
                            children: [
                              Image.network(
                                liveMovie.movieimageurl,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
