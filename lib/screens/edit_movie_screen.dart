import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

    if (movieId == null || movieId == 0) {
      return;
    }

    movie = apiProv.findMovieById(movieId.toInt());
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {


  AppBar appBar = AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).backgroundColor,
        title: movie.id == null
            ? Text(
                AppLocalizations.of(context)!.editMovieAddMovie,
                style: Theme.of(context).textTheme.headline3,
              )
            : Text(
                AppLocalizations.of(context)!.editMovieAppBarTitle,
                style: Theme.of(context).textTheme.headline3,
              ),
        centerTitle: true,
      );


    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - appBar.preferredSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EditAddForm(movie),
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
