import 'package:flutter/material.dart';

class DefaultTheme {
  ThemeData get theme => ThemeData(
        primaryColor: const Color(0xFF2BD17E),
        backgroundColor: const Color(0xFF093545),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xfF224957),
        ),
        cardColor: const Color(0xFF092C39),
        errorColor: const Color(0xFFEB5757),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 64.0,
            fontWeight: FontWeight.w500,
          ),
          headline2: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 48.0,
            fontWeight: FontWeight.w500,
          ),
          headline3: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 36.0,
            fontWeight: FontWeight.w500,
          ),
          headline4: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 16.0,
          ),
          bodyText2: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 14.0,
          ),
          /* bodyLarge: const TextStyle(
            color: Color(0xFfC3C8D4),
            fontFamily: 'Montserrat',
            fontSize: 20.0,
          ),
          bodyMedium: const TextStyle(
            color: Color(0xFfC3C8D4),
            fontFamily: 'Montserrat',
            fontSize: 16.0,
          ),
          bodySmall: const TextStyle(
            color: Color(0xFfC3C8D4),
            fontFamily: 'Montserrat',
            fontSize: 14.0,
          ), */

          caption: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 14.0,
          ),
        ),
      );
}
