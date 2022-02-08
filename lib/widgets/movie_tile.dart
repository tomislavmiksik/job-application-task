import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:job_application_task/models/movie.dart';
import 'package:job_application_task/screens/edit_movie_screen.dart';

class MovieTile extends StatefulWidget {
  final Movie movie;

  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: ExtendedImage.network(
                  widget.movie.posterUrl.toString(),
                  fit: BoxFit.fill,
                  cache: true,
                  enableMemoryCache: true,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
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
                            arguments: {
                              'id': widget.movie.id,
                            },
                          )
                        : null;//reserver for delete
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
              widget.movie.title.toString(),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.movie.year.toString(),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
