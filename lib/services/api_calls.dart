import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie.dart';
import '../screens/home_screen.dart';

class ApiCallsProvider with ChangeNotifier {
  final String baseUrl = 'https://zm-movies-assignment.herokuapp.com';
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
    } else if (prefs.getString('tmpToken') != null) {
      return prefs.getString('tmpToken');
    } else {
      return null;
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

      for (var element in responseData) {
        tmpMovies.add(
          Movie(
            id: element['id'],
            title: element['attributes']['name'],
            year: element['attributes']['publicationYear'],
            posterUrl: element['attributes']['poster']['data']['attributes']
                ['formats']['thumbnail']['url'],
          ),
        );
      }
      _movies = tmpMovies;
      print('movies: ' + _movies.toString());
      notifyListeners();
      return _movies;
    } on DioError catch (e) {
      print(e.response!.statusMessage.toString());
      print(e.response!.statusCode.toString());
      rethrow;
    }
  }

  Future<void> addMovie(String title, int year, String filePath) async {
    token = (await getToken()).toString();
    print('token u addMovie: ' + token);

    var data = {
      'name': title,
      'publicationYear': year,
    };

    var formData = FormData.fromMap({
      'data': jsonEncode(data),
      'files.poster': await MultipartFile.fromFile(filePath,
          filename: '${DateTime.now().millisecondsSinceEpoch}.jpg'),
    });

    try {
      var response = await Dio().post(
        baseUrl + '/api/movies',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      //response.data['data'];
      fetchMovies();
      _movies.add(Movie(
        id: response.data['data']['id'],
        title: title,
        year: year,
        posterUrl: filePath,
      ));
      notifyListeners();
    } on DioError catch (e) {
      print(e.response!.data.toString());
      rethrow;
    }

  }

  Future<void> editMovie(
      int id, String title, int year, String filepath) async {}

  Future<void> deleteMovie(int id) async {
    token = (await getToken()).toString();

    try {
      await Dio().delete(
        baseUrl + '/api/movies/$id',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      _movies.removeWhere((element) => element.id == id);
      fetchMovies();
      notifyListeners();
    } on DioError catch (e) {
      print(e.response!.data.toString());
      rethrow;
    }

    //fetchMovies();
  }

  List<Movie> get getMovies {
    print('movies u getteru ' + _movies.toString());
    return [..._movies];
  }

  //find movie by id
  Movie findMovieById(int id) {
    //print(getMovies);
    return getMovies.firstWhere((element) => element.id == id);
  }
}
