import 'package:flutter/material.dart';
import 'package:job_application_task/services/api_calls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    String? token = await ApiCallsProvider().getToken();

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (token != null) {
          final apiProv = Provider.of<ApiCallsProvider>(context, listen: false);
          await apiProv.fetchMovies();
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          await prefs.remove('tmpToken');
          dispose();
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: const Icon(Icons.exit_to_app),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        height: double.infinity,
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 10),
                    /*  ElevatedButton(
                     
                      child: const Text('Try again'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor,
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size.fromWidth(
                              MediaQuery.of(context).size.width * 0.5),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ), */
                  ],
                ),
              )
            : const Text(
                'Loading...',
              ),
      ),
    );
  }
}
