import 'package:flutter/material.dart';
import 'package:omdb_app/models/Movie.dart' as models;

class MovieItem extends StatelessWidget {
  final models.Movie movie;

  MovieItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 125.0),
          Column(
            children: <Widget>[
              if (this.movie.poster != "N/A")
                Image.network(this.movie.poster, height: 110, width: 110)
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Divider(
                  color: Colors.black,
                ),
                Text(
                  this.movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: searchItemStyle(Colors.green),
                ),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  this.movie.year,
                  style: searchItemStyle(Colors.black),
                ),
                Text(
                  movieData(),
                  style: searchItemStyle(Colors.black),
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      )
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  TextStyle searchItemStyle(Color titleColor) {
    return TextStyle(
      height: 2.0,
      fontFamily: 'Josefin',
      color: titleColor,
      fontWeight: FontWeight.bold,
    );
  }

  String movieData () {
    if (this.movie.language != null) {
      return this.movie.language;
    } else { return "Unavailable";}
  }
}