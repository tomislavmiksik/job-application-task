import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application_task/models/movie.dart';
import 'package:job_application_task/services/api_calls.dart';
import 'package:job_application_task/widgets/empty_list.dart';
import 'package:job_application_task/widgets/movie_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> _movies = [];
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<Movie>> fetchedMovies = ApiCallsProvider().fetchMovies();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: FutureBuilder(
        future: fetchedMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data! as List<Movie>).isEmpty
                ? const Center(child: EmptyListWidget())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'My Movies',
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                IconButton(
                                  icon: const FaIcon(
                                    FontAwesomeIcons.plusCircle,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.signOutAlt,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                ApiCallsProvider().logout();

                                Navigator.of(context)
                                    .pushReplacementNamed('/login');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: MovieGrid(snapshot.data! as List<Movie>),
                        ),
                      ],
                    ),
                  );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            );
          }
          return CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          );
        },
      ),
    );
  }
}
