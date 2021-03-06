import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_application_task/models/movie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/api_calls.dart';
import '../shared/input_field_decoration.dart';

class EditAddForm extends StatefulWidget {
  Movie movie;
  EditAddForm(this.movie, {Key? key}) : super(key: key);

  @override
  _EditAddFormState createState() => _EditAddFormState();
}

class _EditAddFormState extends State<EditAddForm> {
  final _form = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  String? imagePath = '';
  XFile? image;
  ImagePicker picker = ImagePicker();

  void _submitForm() {
    _form.currentState?.save();

    final apiProv = Provider.of<ApiCallsProvider>(context, listen: false);
    if (widget.movie.id != null) {
      apiProv.editMovie(
        widget.movie.id!.toInt(),
        _titleController.text,
        int.parse(_yearController.text),
        imagePath.toString(),
      );
    } else {
      apiProv.addMovie(_titleController.text, int.parse(_yearController.text),
          imagePath.toString());
    }
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, int?>;
    final apiProv = Provider.of<ApiCallsProvider>(context, listen: false);
    final movieId = routeArgs['id'];

    if (movieId == null || movieId == 0) {
      return;
    }
    widget.movie = apiProv.findMovieById(movieId.toInt());
    _titleController.text = widget.movie.title.toString();
    _yearController.text = widget.movie.year.toString();

    super.didChangeDependencies();
  }

  @override
  void initState() {
    imagePath = widget.movie.posterUrl;
    super.initState();
  }

  Future<void> selectImage() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        imagePath = pickedImage?.path;
        image = pickedImage;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _titleController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputFieldDecoration.buildInputDecoration(
                      AppLocalizations.of(context)!.editMovieTitle,
                      context,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputFieldDecoration.buildInputDecoration(
                      AppLocalizations.of(context)!.editMovieYear,
                      context,
                    ),
                  ),
                  const SizedBox(height: 20),

                  //image selection
                  //
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
                      height: 380,
                      child: image == null && widget.movie.posterUrl == ''
                          ? Center(
                              child: Text(
                                  AppLocalizations.of(context)!.editMovieImage),
                            )
                          : image != null
                              ? ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(8),
                                  child: ExtendedImage.file(
                                    File(imagePath!),
                                    fit: BoxFit.fitWidth,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )
                              : ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(8),
                                  child: ExtendedImage.network(
                                    widget.movie.posterUrl.toString(),
                                    fit: BoxFit.fitWidth,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //buttons row
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => _submitForm(),
                            child: Text(
                              AppLocalizations.of(context)!.editMovieSave,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              AppLocalizations.of(context)!.editMovieCancel,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).errorColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
