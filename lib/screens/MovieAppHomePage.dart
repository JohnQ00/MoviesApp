import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omdb_app/screens/MovieDetail.dart';
import 'package:omdb_app/screens/ShapePainter.dart';
import 'package:omdb_app/models/Movie.dart';
import 'package:omdb_app/components/MovieList.dart';
import 'package:omdb_app/services/MovieService.dart';

class App extends StatefulWidget {
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<App> {

  final searchTextController = new TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void itemClick(Movie item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetail(
          movieTitle: item.title,
          imdbID: item.imdbId,
        ),
      ),
    );
  }

  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: MaterialApp(
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color.fromRGBO(51, 255, 153, 10.0), Color.fromRGBO(153, 255, 153, 10.0)]
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      containerText("Movie's", 64.0, 'Bungee', FontWeight.normal),
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 450.0),
                  child: CustomPaint(
                    size: Size(700, 500),
                    painter: ShapePainter(),
                  ),
                ),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.fromLTRB(160.0, 10.0, 80.0, 570.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RotationTransition(
                        child: Image(
                          image: AssetImage('assets/images/movie.png'),
                        ),
                        turns: new AlwaysStoppedAnimation(315/360),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 375.0, horizontal: 75.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      containerText('Search for any movie you want', 20.0, 'Josefin', FontWeight.bold),
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 162.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Made by John Dutra',
                        style: TextStyle(
                          fontFamily: 'Josefin',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(122, 118, 118, 100.0),
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: searchTextController,
                        onEditingComplete: () {
                          setState(() {
                            searchText = searchTextController.text;
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                          });
                        },
                        focusNode: myFocusNode,
                        //textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.black, width: 1.0),
                          ),
                          labelText: 'Type here the movie name or ID',
                          labelStyle: TextStyle(
                            fontFamily: 'Josefin',
                            fontWeight: FontWeight.bold,
                            color: searchTextColor(myFocusNode),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      if (searchText.length > 0)
                        FutureBuilder<List<Movie>>(
                            future: searchMechanism(searchText),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Expanded(
                                  child: MovieList(
                                    movies: snapshot.data,
                                    itemClick: this.itemClick,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Movie not found!",
                                    style: TextStyle(
                                      fontFamily: 'Josefin',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                              return LinearProgressIndicator();
                            }),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}

Text containerText(String text, double font, String fontFamily, FontWeight fontWeight) {
  return Text(
      text,
      style: TextStyle(
        fontSize: font,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      )
  );
}

Color searchTextColor(FocusNode myFocusNode) {
  if (myFocusNode.hasFocus || !myFocusNode.hasFocus) {
    return Colors.black;
  }
}