import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application_task/models/movie.dart';
import 'package:job_application_task/services/api_calls.dart';
import 'package:job_application_task/widgets/empty_list.dart';
import 'package:job_application_task/widgets/movie_grid.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> _movies = [];
  bool _isLoading = false;
  var apiProv;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Future<void> fetchedMovies = ApiCallsProvider().fetchMovies();
    apiProv = Provider.of<ApiCallsProvider>(context);
    return Scaffold(
      floatingActionButton: apiProv.getMovies.isEmpty
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () async {
                apiProv.fetchMovies();
                setState(
                  () {
                    _movies = apiProv.getMovies;
                  },
                );
              },
              child: const Icon(Icons.refresh),
            )
          : null,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: FutureBuilder(
        future: fetchedMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return apiProv.getMovies.isEmpty
                ? const SingleChildScrollView(
                    child: EmptyListWidget(),
                  )
                : SingleChildScrollView(
                    child: RefreshIndicator(
                      backgroundColor: Theme.of(context).backgroundColor,
                      color: Theme.of(context).primaryColor,
                      onRefresh: () async {
                        apiProv.fetchMovies();
                        setState(
                          () {
                            _movies = apiProv.getMovies;
                          },
                        );
                      },
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
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const FaIcon(
                                      FontAwesomeIcons.plusCircle,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/edit-movie',
                                        arguments: {'id': 0},
                                      );
                                    },
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
                                  Navigator.of(
                                    context,
                                  ).pushReplacementNamed('/login');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: MovieGrid(
                              snapshot.data! as List<Movie>,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: SvgPicture.asset(
                              'assets/images/Vectors.svg',
                            ),
                          ),
                        ],
                      ),
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
