import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_application_task/shared/input_field_decoration.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../services/api_calls.dart';
import '../widgets/edit_add_form.dart';

class EditMovieScreen extends StatefulWidget {
  const EditMovieScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-movie';

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  late Movie movie = Movie(
    id: null,
    title: '',
    year: 0,
    posterUrl: '',
  );

  ImagePicker picker = ImagePicker();
  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, int?>;
    final apiProv = Provider.of<ApiCallsProvider>(context, listen: false);
    final movieId = routeArgs['id'];
    final isEdit = routeArgs['isEdit'];

    if(movieId == null || movieId == 0) {
      return;
    }

    movie = apiProv.findMovieById(movieId.toInt());
    super.didChangeDependencies();
  }
  @override
  void initState() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).backgroundColor,
        title: movie.id == null
            ? Text(
                'Add a movie',
                style: Theme.of(context).textTheme.headline3,
              )
            : Text(
                'Edit Movie',
                style: Theme.of(context).textTheme.headline3,
              ),
        centerTitle: true,
      ),
      body: EditAddForm(movie),
    );
  }
}
