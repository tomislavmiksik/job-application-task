import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie.dart';
import '../screens/home_screen.dart';

class ApiCallsProvider with ChangeNotifier {
  final String baseUrl = 'https://zm-movies-assignment.herokuapp.com';
  String token = '';

  List<Movie> movies = [];

  Future<void> login(String email, String password, bool checkValue) async {
    final prefs = await SharedPreferences.getInstance();

    var formData = FormData.fromMap(
      {
        'identifier': email,
        'password': password,
      },
    );

    try {
      var response =
          await Dio().post(baseUrl + '/api/auth/local', data: formData);
      token = await response.data['jwt'];

      await prefs.setString('tmpToken', token);

      if (checkValue) {
        await prefs.setString('token', token);
      }
    } on DioError catch (e) {
      rethrow;
    }
    //print('token u loginu ' + token);
    notifyListeners();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') != null) {
      return prefs.getString('token');
    } else {
      return prefs.getString('tmpToken');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<List<Movie>> fetchMovies() async {
    List<Movie> tmpMovies = [];
    //var tmpToken = await getToken();
    token = (await getToken()).toString();

    try {
      var response = await Dio().get(
        baseUrl + '/api/movies?populate=*',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      List responseData = response.data['data'];
      responseData.forEach(
        (element) {
          Movie movie = Movie(
            id:  element['id'],
            title: element['attributes']['name'],
            year: element['attributes']['publicationYear'],
            posterUrl: element['attributes']['poster']['data']['attributes']
                ['formats']['small']['url'],
          );
          tmpMovies.add(movie);
        },
      );
      movies.addAll(tmpMovies);
      print('u fetcheru  movies ' + movies.toString());
      notifyListeners();
      return movies;
    } on DioError catch (e) {
      print(e.response!.statusMessage.toString());
      print(e.response!.statusCode.toString());
      rethrow;
    }

    notifyListeners();
  }

  List<Movie> get getMovies {
    //print('u getteru movies ' + movies[0].title.toString());
    return movies;
  }
}
