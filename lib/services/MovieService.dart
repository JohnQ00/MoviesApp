import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omdb_app/models/Movie.dart';

const API_KEY = "c953fa44";
const API_URL = "https://www.omdbapi.com/?apikey=";

Future <List<Movie>> searchMechanism(keyword) async {
  final response = await http.get('$API_URL$API_KEY&s=$keyword');

  if (response.statusCode == 200) {
    Map data = json.decode(response.body);

    if (data['Response'] == "True") {
      var list = (data["Search"] as List)
          .map((item) => new Movie.fromJson(item))
          .toList();
      return list;
    } else {
      throw Exception(data['Error']);
    }
  } else {
    throw Exception("Failed to load movies");
  }
}

Future <Movie> getMovie(movieId) async {
  final response = await http.get('$API_URL$API_KEY&i=$movieId');

  if (response.statusCode == 200) {
    Map data = json.decode(response.body);

    if (data['Response'] == "True") {
      return Movie.fromJson(data);
    } else {
      throw Exception(data['Error']);
    }
  } else {
    throw Exception("Failed to find the movie");
  }
}