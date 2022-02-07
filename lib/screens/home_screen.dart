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
    //ApiCallsProvider().fetchMovies();
    //_movies.addAll(ApiCallsProvider().getMovies);
    print('initState ' + _movies.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<Movie>> fetchedMovies = ApiCallsProvider().fetchMovies();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        //foregroundColor: Colors.transparent,

        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.signOutAlt,
            ),
            onPressed: () {
              ApiCallsProvider().logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchedMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MovieGrid(snapshot.data as List<Movie>);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        },
      ),
    );
  }
}
