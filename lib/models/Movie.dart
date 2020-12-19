class Movie {
  final String imdbId;
  final String poster;
  final String title;
  final String year;
  final String genre;
  final String director;
  final String plot;
  final String imdbRating;
  final String metaScore;
  final String language;

  Movie({
    this.imdbId,
    this.poster,
    this.title,
    this.year,
    this.director,
    this.genre,
    this.imdbRating,
    this.metaScore,
    this.plot,
    this.language,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      imdbId: json["imdbID"],
      title: json["Title"],
      year: json["Year"],
      poster: json["Poster"],
      director: json["Director"],
      genre: json["Genre"],
      imdbRating: json["imdbRating"],
      metaScore: json["Metascore"],
      plot: json["Plot"],
      language: json["Language"],
    );
  }
}