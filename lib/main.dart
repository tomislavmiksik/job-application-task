import 'package:flutter/material.dart';
import 'package:job_application_task/screens/edit_movie_screen.dart';
import 'package:job_application_task/screens/home_screen.dart';
import 'package:job_application_task/screens/loading_screen.dart';
import 'package:job_application_task/screens/login_screen.dart';
import 'package:job_application_task/services/api_calls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants/default_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove('tmpToken');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiCallsProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Movie App',
        theme: DefaultTheme().theme,
        routes: {
          '/': (ctx) => const LoadingScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          EditMovieScreen.routeName: (ctx) => const EditMovieScreen(),
        },
      ),
    );
  }
}
