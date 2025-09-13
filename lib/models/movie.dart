class Movie {
  final String posterUrl;
  final String title;
  final String overview;
  bool liked;

  Movie({
    required this.posterUrl,
    required this.title,
    required this.overview,
    this.liked = false,
  });
}