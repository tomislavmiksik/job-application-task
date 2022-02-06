import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie.dart';
import '../screens/home_screen.dart';

class ApiCallsProvider with ChangeNotifier {
  final String baseUrl =
      'https://zm-movies-assignment.herokuapp.com/api/auth/local';
  String token = '';

  List<Movie> _movies = [];

  Future<void> login(String email, String password, bool checkValue) async {
    final prefs = await SharedPreferences.getInstance();
    var formData = FormData.fromMap(
      {
        'identifier': email,
        'password': password,
      },
    );
    try {
      var response = await Dio().post(baseUrl, data: formData);
      token = response.data['jwt'];

      if (checkValue) {
        await prefs.setString('token', token);
      }
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<void> getMovies() async {
    try {
      var response = await Dio().get(
        '$baseUrl/api/movies?populate=*',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      
    } on DioError catch (e) {
      rethrow;
    }
  }
}
