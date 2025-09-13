import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/api_service.dart';
import '../models/movie.dart';

class HomeProvider with ChangeNotifier {
  List<Movie> movies = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchMovies(String token) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final response = await ApiService().get(
        '/movie/list',
        headers: {'Authorization': 'Bearer $token'},
      );
      final List data = response.data['data'] ?? [];
      movies = data.map((e) => Movie.fromJson(e)).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = 'Filmler yüklenemedi';
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(int movieId) async {
    final index = movies.indexWhere((m) => m.id == movieId);
    if (index != -1) {
      final newFav = !movies[index].isFavorite;
      movies[index] = Movie(
        id: movies[index].id,
        title: movies[index].title,
        posterUrl: movies[index].posterUrl,
        overview: movies[index].overview,
        isFavorite: newFav,
      );
      notifyListeners();
      // API'ye isteği gönder
      try {
        await ApiService().post(
          '/movie/favorite/$movieId',
          headers: {},
        );
      } catch (_) {}
    }
  }

  // Fotoğraf upload için
  Future<bool> uploadPhoto(String token, File file) async {
    try {
      final resp = await ApiService().postMultipart(
        '/user/upload_photo',
        file: file,
        fileField: "file",
        headers: {'Authorization': 'Bearer $token'},
      );
      return resp.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}