import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          //margin: const EdgeInsets.only(top: 200),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 200),
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(
                  'assets/images/Vectors.svg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
