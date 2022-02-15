import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.signIn,
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
      ),
    );
  }
}
