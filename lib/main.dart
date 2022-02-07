import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:job_application_task/screens/home_screen.dart';
import 'package:job_application_task/screens/loading_screen.dart';
import 'package:job_application_task/screens/login_screen.dart';
import 'package:job_application_task/services/api_calls.dart';
import 'package:provider/provider.dart';

import 'themes/default_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiCallsProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), 
          Locale('es', ''), 
          Locale('hr', ''),
          Locale('de', ''),
          Locale('fr', ''),
          Locale('it', ''),
          Locale('pt', ''),
          Locale('ru', ''),
          Locale('tr', ''),
          Locale('zh', ''),
          Locale('ja', ''),
          Locale('ko', ''),
          Locale('nl', ''),
          Locale('sv', ''),
          Locale('pl', ''),
          Locale('da', ''),
        ],
        title: 'Flutter Demo',
        theme: DefaultTheme().theme,
        routes: {
          '/': (ctx) => LoadingScreen(),
          LoginScreen.routeName : (ctx) => LoginScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
