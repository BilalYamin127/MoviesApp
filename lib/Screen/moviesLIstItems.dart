import 'package:flutter/material.dart';
import 'package:moviesapp/Screen/moviesDetailsScreen.dart';
import 'package:moviesapp/data/moviedData.dart';
import 'package:moviesapp/model/movie.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({
    super.key,
  });

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final List<Movie> myMovies = dummyMovies;
  int _selectedCategoryIndex = 0;
  final List<Category> categories = Category.values;
  String _selectedImageUrl = "";
  String _selectedActorImageUrl = "";
  String _selectedTitle = "";
  String _duration = "";
  Movie? _selectedMovie;

  List<Movie> getFilteredMovies() {
    return myMovies
        .where((movie) => movie.category == categories[_selectedCategoryIndex])
        .toList();
  }

  void _updateSelectedMovie(Movie movie) {
    setState(() {
      _selectedMovie = movie;
    });
  }

  @override
  void initState() {
    super.initState();
    // Assuming `myMovies` is a list that's already populated.
    _setInitialMovieDetails();
  }

  void _setInitialMovieDetails() {
    // Find the first movie that matches the selected category.
    Movie? firstMovie = myMovies.firstWhere(
      (movie) => movie.category == categories[_selectedCategoryIndex],
    );

    // Update the UI if a movie was found.
    if (firstMovie != null) {
      _updateMovieDetails(firstMovie);
    }
  }

  void _updateMovieDetails(Movie movie) {
    setState(() {
      _selectedImageUrl = movie.movieimageurl;
      _selectedActorImageUrl = movie.movieactorurl;
      _selectedTitle = movie.title;
      _duration = movie.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Category> firstThreeCategories = categories.sublist(0, 3);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: [
            Container(
              height: 400,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: _selectedImageUrl.isNotEmpty
                    ? Image.network(
                        _selectedImageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      )
                    : const Center(child: Text("No Movie Selected")),
              ),
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(69, 37, 34, 27),
                      borderRadius: BorderRadius.circular(23)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                            _selectedActorImageUrl,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              _selectedTitle,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            // padding: EdgeInsets.fromLTRB(2, 12.0, 0, 0),
                            child: Text(
                              _duration,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            final selectedMovie =
                                getFilteredMovies().firstWhere(
                              (selectedm) => selectedm.title == _selectedTitle,
                            );
                            _updateSelectedMovie(selectedMovie);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoviesDetailsScreen(
                                        selectedMovie: selectedMovie,
                                      )),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red.shade300),
                          ),
                          child: const Text(
                            'Live Now',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ]),
        ),
        // Category Tabs
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: firstThreeCategories.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedCategoryIndex == index
                          ? Colors.white // Color of underline when selected
                          : Colors
                              .transparent, // Transparent underline when not selected
                      width: 2, // Width of the underline
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    categories[index].toString().split('.').last.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _selectedCategoryIndex == index
                          ? Colors.white
                          : Colors.white54,
                      fontWeight: FontWeight.bold,
                      decoration: _selectedCategoryIndex == index
                          ? TextDecoration
                              .underline // Add underline if selected
                          : TextDecoration.none, // No underline if not selected
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Horizontal List for Selected Category
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: getFilteredMovies()
                  .map(
                    (movie) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImageUrl = movie.movieimageurl;
                          _selectedActorImageUrl = movie.movieactorurl;
                          _duration = movie.duration;
                          _selectedTitle = movie.title;
                        });
                      },
                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(40, 109, 62, 179),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _selectedImageUrl == movie.movieimageurl
                                ? const Color.fromARGB(255, 13, 206, 52)
                                : const Color.fromARGB(0, 204, 179,
                                    179), // Adjust the border color as needed
                            width: 4,
                            // Adjust the border width as needed
                          ),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              movie.movieimageurl,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                                top: 2,
                                right: 2,
                                child: Text(
                                  movie.duration,
                                  style: const TextStyle(color: Colors.white),
                                )),
                            Positioned(
                                bottom: 2,
                                right: 2,
                                left: 2,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundImage:
                                          NetworkImage(movie.movieactorurl),
                                    ),
                                    Positioned(
                                        bottom: 2,
                                        right: 4,
                                        left: 8,
                                        child: Text(
                                          movie.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
