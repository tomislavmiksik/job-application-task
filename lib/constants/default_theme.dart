import 'package:flutter/material.dart';

class DefaultTheme {
  ThemeData get theme => ThemeData(
        primaryColor: const Color(0xFF2BD17E),
        backgroundColor: const Color(0xFF093545),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xfF224957),
        ),
        indicatorColor: const Color(0xFF2BD17E),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF2BD17E),
          //textTheme: ButtonTextTheme.primary,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF2BD17E),
          selectionColor: Color.fromARGB(129, 43, 209, 126),
          selectionHandleColor: Color.fromARGB(188, 43, 209, 126),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF2BD17E),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        //cardColor: const Color(0xFF092C39),
        errorColor: const Color(0xFFEB5757),
        textTheme: const TextTheme(
          
          overline: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          subtitle1: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          subtitle2: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          button: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 18,
            decorationColor: Colors.white,
            fontWeight: FontWeight.w500,
            inherit: true,
          ),
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
          caption: TextStyle(
            color: Color(0xFfFFFFFF),
            fontFamily: 'Montserrat',
            fontSize: 14.0,
          ),
        ),
      );
}
