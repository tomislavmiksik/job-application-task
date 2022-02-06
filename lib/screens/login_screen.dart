import 'package:flutter/material.dart';

import '../widgets/login_form_widget.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                'Sign in',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 16),
              const Center(
                widthFactor: 1,
                heightFactor: 1.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LoginForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

