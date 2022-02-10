import 'dart:io';

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
        ApiCallsProvider().fetchMovies();
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
            decoration: InputFieldDecoration.buildInputDecoration('Email', context),
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
            decoration: InputFieldDecoration.buildInputDecoration('Password', context),
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
                const Text(
                  'Remember me',
                  style: TextStyle(color: Colors.white),
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
                    Theme.of(context).primaryColor),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size.fromWidth(MediaQuery.of(context).size.width),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text('Login'),
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
