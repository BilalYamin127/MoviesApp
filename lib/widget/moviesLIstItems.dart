import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moviesapp/data/moviedData.dart';
import 'package:moviesapp/model/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesListItem extends StatefulWidget {
  const MoviesListItem({
    super.key,
  });

  @override
  State<MoviesListItem> createState() => _MoviesListItemState();
}

class _MoviesListItemState extends State<MoviesListItem> {
  final List<Movie> myMovies = dummyMovies;
  int _selectedCategoryIndex = 0;
  final List<Category> categories = Category.values;

  List<Movie> getFilteredMovies() {
    return myMovies
        .where((movie) => movie.category == categories[_selectedCategoryIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 350,
          width: double.infinity,
          color: Colors.red,
        ),
        // Category Tabs
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
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
                  color: _selectedCategoryIndex == index
                      ? Colors.blueAccent
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    categories[index].toString().split('.').last.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _selectedCategoryIndex == index
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
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
                    (movie) => Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23),
                            ),
                            child: Stack(
                              children: [
                                FadeInImage(
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: NetworkImage(movie.movieimageurl),
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                ),
                                Positioned(
                                    top: 2,
                                    right: 2,
                                    child: Text(
                                      movie.duration,
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
                                            style:
                                                TextStyle(color: Colors.amber),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          )),
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
