import 'package:flutter/material.dart';
import 'package:job_application_task/models/movie.dart';

class MovieGrid extends StatelessWidget {
  
  final List<Movie> movies;
  
  const MovieGrid(this.movies, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(movies[index].posterUrl.toString()),
                  title: Text(
                    movies[index].title.toString(),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
          } 
}