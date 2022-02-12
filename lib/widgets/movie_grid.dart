import 'package:flutter/material.dart';
import 'package:job_application_task/models/movie.dart';
import 'package:job_application_task/widgets/movie_tile.dart';
import 'package:provider/provider.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const MovieGrid(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: movies[index],
        child: const MovieTile(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      ),
    );
  }
}
