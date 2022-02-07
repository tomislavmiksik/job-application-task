import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      title: const Text(
        'Incorrect credentials',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
        ),
      ),
      content: const Text(
        'Please check if you typed the correct email and password',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Ok',
            style: TextStyle(
              color: Color(0xFF2BD17E),
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
