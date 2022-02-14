import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text(
        AppLocalizations.of(context)!.loginError,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
        ),
      ),
      content: Text(
        AppLocalizations.of(context)!.loginErrorDescription,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).backgroundColor),
          ),
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
