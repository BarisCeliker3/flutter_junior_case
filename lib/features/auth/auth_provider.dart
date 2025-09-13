import 'package:flutter/material.dart';
import '../../core/api_service.dart';
import 'package:dio/dio.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  String? error;
  String? _token; // Token saklama

  String? get token => _token; // Getter

  void setToken(String? newToken) {
    _token = newToken;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final response = await ApiService().post('/user/login', data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200 && response.data['data'] != null && response.data['data']['token'] != null) {
        setToken(response.data['data']['token']);
      }
      isLoading = false;
      notifyListeners();
      return response.statusCode == 200;
    } catch (e) {
      if (e is DioError && e.response != null && e.response?.data != null) {
        error = e.response?.data['message']?.toString() ?? 'Giriş başarısız';
      } else {
        error = 'Giriş başarısız';
      }
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password, String username) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final response = await ApiService().post('/user/register', data: {
        'email': email,
        'password': password,
        'name': username,
      });
      isLoading = false;
      notifyListeners();
      return response.statusCode == 200;
    } catch (e) {
      if (e is DioError && e.response != null && e.response?.data != null) {
        // DEBUG: API'den dönen tüm response'u konsola yazdır
        // ignore: avoid_print
        print('REGISTER ERROR RESPONSE: ${e.response?.data}');
        error = e.response?.data['message']?.toString() ?? 'Kayıt başarısız';
      } else {
        error = 'Kayıt başarısız';
      }
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}