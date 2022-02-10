import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../services/api_calls.dart';

class EditMovieScreen extends StatefulWidget {
  const EditMovieScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-movie';

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  late Movie movie = Movie(
    id: 0,
    title: '',
    year: 0,
    posterUrl: '',
  );
  var _isInit = true;
  final _form = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  var image;

  ImagePicker picker = ImagePicker();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, int?>;
      final apiProv = Provider.of<ApiCallsProvider>(context, listen: false);
      final movieId = routeArgs['id'];

      if (movieId == 0) {
        return;
      }
      print(movieId);

      movie = apiProv.findMovieById(movieId!.toInt());
    }
    super.didChangeDependencies();
  }

  Future<void> selectImage() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      //print('URL ' + pickedImage!.path.toString());
      this.image = pickedImage;
    });
  }

  void _submitForm() {
    final isValid = _form.currentState?.validate();
    _form.currentState?.save();

    final apiProv = Provider.of<ApiCallsProvider>(context, listen: false);
    apiProv.addMovie(
        _titleController.text, int.parse(_yearController.text), image.path.toString());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).backgroundColor,
        title: movie.id == 0
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _titleController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        color: Color(0xFFEB5757),
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller:
                        _yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        color: Color(0xFFEB5757),
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
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
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => selectImage(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      height: 400,
                      child: image == null && movie.posterUrl == ''
                          ? const Center(
                              child: Text('Add an image'),
                            )
                          : image == null
                              ? Center(
                                  child: ExtendedImage.network(
                                    movie.posterUrl.toString(),
                                  ),
                                )
                              : Center(
                                  child: Image.file(
                                    File(image.path),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          //color: Theme.of(context).primaryColor,
                          onPressed: () => _submitForm(),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          //color: Theme.of(context).primaryColor,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
