import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application_task/services/api_calls.dart';
import 'package:job_application_task/widgets/empty_list.dart';
import 'package:job_application_task/widgets/movie_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ApiCallsProvider apiProv;

  @override
  Widget build(BuildContext context) {
    //final Future<void> fetchedMovies = ApiCallsProvider().fetchMovies();
    apiProv = Provider.of<ApiCallsProvider>(context);

    apiProv.fetchMovies();
    return Scaffold(
      floatingActionButton: apiProv.getMovies.isEmpty
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () async {
                apiProv.fetchMovies();
                setState(
                  () {
                  },
                );
              },
              child: const Icon(Icons.refresh),
            )
          : null,
      backgroundColor: Theme.of(context).backgroundColor,
      body: apiProv.getMovies.isEmpty
          ? const EmptyListWidget()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            AppLocalizations.of(context)!.myMovies,
                            style: Theme.of(context).textTheme.headline3,
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
                RefreshIndicator(
                  backgroundColor: Theme.of(context).backgroundColor,
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    apiProv.fetchMovies();
                    setState(
                      () {
                      },
                    );
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: MovieGrid(
                      apiProv.getMovies,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
