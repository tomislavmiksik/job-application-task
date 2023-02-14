import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie.dart';

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

  Future downloadPoster(String url, String savePath) async {
    try {
      Response response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
    }
  }

  Future<void> fetchMovies() async {
    List<Movie> tmpMovies = [];
    token = (await getToken()).toString();

    try {
      var response = await Dio().get(
        baseUrl + '/api/movies?populate=*',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      List responseData = response.data['data'];

      for (final element in responseData) {
        if (element['attributes']['poster']['data'] == null) {
          element['attributes']['poster']['data'] = {
            'attributes': {
              'formats': {
                'thumbnail': {
                  'url':
                      'https://via.placeholder.com/150/000000/FFFFFF/?text=No+image'
                }
              }
            }
          };
        }
        String imgUrl;

        if (element['attributes']['poster']['data']['attributes']['formats']
                ['small'] !=
            null) {
          imgUrl = element['attributes']['poster']['data']['attributes']
              ['formats']['small']['url'];
        } else {
          imgUrl = element['attributes']['poster']['data']['attributes']
              ['formats']['thumbnail']['url'];
        }

        tmpMovies.add(
          Movie(
            id: element['id'],
            title: element['attributes']['name'],
            year: element['attributes']['publicationYear'],
            posterUrl: imgUrl,
          ),
        );
      }
      _movies = tmpMovies;
      notifyListeners();
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<void> addMovie(String title, int year, String filePath) async {
    token = (await getToken()).toString();

    var data = {
      'name': title,
      'publicationYear': year,
    };

    var formData = FormData.fromMap(
      {
        'data': jsonEncode(data),
        'files.poster': await MultipartFile.fromFile(filePath,
            filename: '${DateTime.now().millisecondsSinceEpoch}.jpg'),
      },
    );

    try {
      var response = await Dio().post(
        baseUrl + '/api/movies',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      fetchMovies();
      _movies.add(Movie(
        id: response.data['data']['id'],
        title: title,
        year: year,
        posterUrl: filePath,
      ));
      notifyListeners();
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<void> editMovie(
      int id, String title, int year, String filePath) async {
    token = (await getToken()).toString();

    var data = {
      'name': title,
      'publicationYear': year,
    };

    var tempDir = await getTemporaryDirectory();

    String fullPath = filePath;
        

    if (filePath.startsWith('http')) {
      fullPath = tempDir.path + '/' + DateTime.now().millisecondsSinceEpoch.toString() + "." + filePath.split('.').last;
      await downloadPoster(
        filePath,
        fullPath,
      );
    } 

    var formData = FormData.fromMap(
      {
        'data': jsonEncode(data),
        'files.poster': await MultipartFile.fromFile(fullPath,
            filename: '${DateTime.now().millisecondsSinceEpoch}' + filePath.split('.').last),
      },
    );

    try {
      await Dio().put(
        baseUrl + '/api/movies/$id',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      notifyListeners();
    } on DioError catch (e) {

      rethrow;
    }
  }

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
      rethrow;
    }

  }

  List<Movie> get getMovies {
    return [..._movies];
  }

  Movie findMovieById(int id) {
    return getMovies.firstWhere((element) => element.id == id);
  }
}
