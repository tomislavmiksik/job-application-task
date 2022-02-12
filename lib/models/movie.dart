import 'package:flutter/cupertino.dart';

class Movie with ChangeNotifier {
  int? id;
  String? title;
  int? year;
  String? posterUrl;

  Movie({
    this.id,
    this.title,
    this.year,
    this.posterUrl,
  });

  void editMovie(
    String? title,
    int? year,
    String? posterUrl,
  ) {
    this.title = title;
    this.year = year;
    this.posterUrl = posterUrl;
    notifyListeners();
  }
  
}
