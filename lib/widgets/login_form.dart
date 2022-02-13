import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:job_application_task/screens/home_screen.dart';
import 'package:job_application_task/services/api_calls.dart';
import 'package:job_application_task/shared/input_field_decoration.dart';

import 'error_dialog.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool checkValue = false;
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  updateCheck(value) {
    setState(() {
      checkValue = value;
    });
  }

  submitForm() async {
    //_form.currentState?.save();
    if (ApiCallsProvider().getToken() != null) {
      try {
        await ApiCallsProvider()
            .login(_emailController.text, _passwordController.text, checkValue);
        await ApiCallsProvider().fetchMovies();
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } catch (error) {
        showDialog(context: context, builder: (ctx) => const ErrorDialog());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          //email input
          //
          //
          TextFormField(
            cursorColor: Theme.of(context).primaryColor,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.bodyText1,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration:
                InputFieldDecoration.buildInputDecoration('Email', context),
          ),
          const SizedBox(
            height: 24,
          ),
          //password input
          //
          //
          TextFormField(
            cursorColor: Theme.of(context).primaryColor,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.bodyText1,
            controller: _passwordController,
            keyboardType: TextInputType.text,
            obscureText: !_passwordVisible,
            autocorrect: false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(
                color: Color(0xFFEB5757),
                fontWeight: FontWeight.bold,
              ),
              labelText: AppLocalizations.of(context)!.password,
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                //splashRadius: 0,
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(
                    () {
                      _passwordVisible = !_passwordVisible;
                    },
                  );
                },
              ),
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              filled: true,
              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                  activeColor: Theme.of(context).primaryColor,
                  value: checkValue,
                  onChanged: (val) {
                    updateCheck(val);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    updateCheck(!checkValue);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.rememberMe,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor,
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size.fromWidth(MediaQuery.of(context).size.width),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.signInButton),
              onPressed: () {
                submitForm();
              },
            ),
          ),
        ],
      ),
    );
  }
}
