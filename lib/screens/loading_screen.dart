import 'package:flutter/material.dart';
import 'package:job_application_task/models/movie.dart';
import 'package:job_application_task/services/api_calls.dart';
import 'package:provider/provider.dart';

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
      const Duration(seconds: 2),
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : const Text(
                'Loading...',
              ),
      ),
    );
  }
}
