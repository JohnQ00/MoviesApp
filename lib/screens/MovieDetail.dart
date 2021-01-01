
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omdb_app/screens/ShapePainter.dart';
import 'package:omdb_app/services/MovieService.dart';
import 'package:omdb_app/models/Movie.dart';

class MovieDetail extends StatelessWidget {
  final String movieTitle;
  final String imdbID;

  MovieDetail({this.movieTitle, this.imdbID});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      body: FutureBuilder<Movie>(
        future: getMovie(this.imdbID),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color.fromRGBO(51, 255, 153, 10.0), Color.fromRGBO(153, 255, 153, 10.0)]
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                    alignment: Alignment.center,
                    child: Image.network(
                      snapshot.data.poster,
                      width: 150.0,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 5.0,
                    height: 15.0,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 75.0,
                        width: 500.0,
                        child: Text(
                          snapshot.data.title,
                          textAlign: TextAlign.justify,
                          textWidthBasis: TextWidthBasis.longestLine,
                          style: itemDetailStyle(Colors.white, 20.0),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 25.0,
                        width: 500.0,
                        child: Text(
                          snapshot.data.director,
                          textAlign: TextAlign.justify,
                          style: itemDetailStyle(Colors.black, 12.0),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 5.0,
                    height: 15.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(snapshot.data.plot, textAlign: TextAlign.justify, style: itemDetailStyle(Colors.black, 15.0),),
                      Divider(color: Colors.black, thickness: 1.0, height: 15.0,),
                      Text('Genre', textAlign: TextAlign.justify, style: itemDetailStyle(Colors.grey, 12.0),),
                      Text(snapshot.data.genre, textAlign: TextAlign.justify, style: itemDetailStyle(Colors.black, 15.0),),
                      Divider(color: Colors.black, thickness: 1.0, height: 15.0,),
                      Text('Year', textAlign: TextAlign.justify, style: itemDetailStyle(Colors.grey, 12.0),),
                      Text(snapshot.data.year, textAlign: TextAlign.justify, style: itemDetailStyle(Colors.black, 15.0),),
                      Divider(color: Colors.black, thickness: 1.0, height: 15.0,),
                      Text('Language', textAlign: TextAlign.justify, style: itemDetailStyle(Colors.grey, 12.0),),
                      Text(snapshot.data.language, textAlign: TextAlign.justify, style: itemDetailStyle(Colors.black, 15.0),),
                      Divider(color: Colors.black, thickness: 5.0, height: 15.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              height: 45.0,
                              width: 20.0,
                              child: Text('IMDB: ' + snapshot.data.imdbRating + '/10', textAlign: TextAlign.justify, style: itemDetailStyle(Colors.white, 20.0),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              height: 45.0,
                              width: 20.0,
                              child: Text('MetaCritic: ' + snapshot.data.metaScore + '/100', textAlign: TextAlign.justify, style: itemDetailStyle(Colors.white, 20.0),),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if(snapshot.hasError) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 425.0, horizontal: 125.0),
              child: Text(
                "${snapshot.error}",
                style: TextStyle(
                fontFamily: 'Josefin',
                fontWeight: FontWeight.bold,
              ),
            ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  TextStyle itemDetailStyle(Color titleColor, double fontSize) {
    return TextStyle(
      height: 2.0,
      fontFamily: 'Josefin',
      color: titleColor,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );
  }
}
