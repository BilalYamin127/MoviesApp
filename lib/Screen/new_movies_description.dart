import 'package:expandable_text/expandable_text.dart';

import 'package:flutter/material.dart';

import 'package:moviesapp/model/movie_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.originalTitle ?? 'no title avaiable '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    movie.title ?? 'No Title Available',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      backgroundColor: Colors.black.withOpacity(0.5),
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
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          right: BorderSide(color: Colors.black),
                        )),
                        child: Text(
                          'votes:${movie.voteAverage}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  ), // Example views
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                        color: Colors.black,
                      ))),
                      child: Text(
                        'title:${movie.title} ',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  // Text('Title: ${movie.title}'),
                  Expanded(
                    child: Text(
                      'date :${movie.releaseDate}',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0), // Add padding around the text
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                      height:
                          8), // Add some space between the label and the description
                  ExpandableText(
                    '${movie.overview}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
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

            // You can add more details in similar fashion here
          ],
        ),
      ),
    );
  }
}
