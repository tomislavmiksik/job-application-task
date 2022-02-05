import 'package:flutter/material.dart';
import 'package:job_application_task/screens/home_screen.dart';
import 'package:job_application_task/screens/login_screen.dart';

import 'themes/default_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DefaultTheme().theme,
      routes: {
        '/': (ctx) => LoginScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
    );
  }
}
