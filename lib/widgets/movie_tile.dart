import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:job_application_task/models/movie.dart';
import 'package:job_application_task/screens/edit_movie_screen.dart';
import 'package:job_application_task/services/api_calls.dart';
import 'package:provider/provider.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = Provider.of<Movie>(context);

    void deleteMovie(int id) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text('Are you sure?'),
          content: const Text(
            'Do you want to delete this movie permanently?',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            MaterialButton(
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              //color: Theme.of(context).errorColor,
              onPressed: () => Navigator.of(context).pop(false),
            ),
            MaterialButton(
              //color: Theme.of(context).primaryColor,

              child: Text(
                'Yes',
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
              onPressed: () async {
                await ApiCallsProvider().deleteMovie(id);
                ApiCallsProvider().fetchMovies();
                Navigator.of(ctx).pop(true);
              },
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: ExtendedImage.network(
                    movie.posterUrl.toString(),
                    fit: BoxFit.cover,
                    //cache: true,
                    width: double.infinity,
                    enableMemoryCache: true,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: PopupMenuButton(
                  color: Theme.of(context).backgroundColor,
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (value) {
                    value == 1
                        ? Navigator.of(context).pushNamed(
                            EditMovieScreen.routeName,
                            arguments: {'id': movie.id, 'isEdit': 1},
                          )
                        : deleteMovie(
                            movie.id!.toInt(),
                          );
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          'Edit',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          'Delete',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              movie.title.toString(),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              movie.year.toString(),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
