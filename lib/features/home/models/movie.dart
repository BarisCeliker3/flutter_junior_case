class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.isFavorite,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterUrl: json['poster_url'] ?? '',
      overview: json['overview'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
    );
  }
}
