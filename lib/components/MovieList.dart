import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:omdb_app/models/Movie.dart';
import 'package:omdb_app/components/MovieItem.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final Function itemClick;

  MovieList({this.movies, this.itemClick});

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: this.movies.length,
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: MovieItem(movie: this.movies[index]),
            onTap: () => this.itemClick(this.movies[index]),
          );
        },
      ),
    );
  }
}