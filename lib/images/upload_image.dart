import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secand_in_firebase/bloc/bloc/images_bloc.dart';
import 'package:secand_in_firebase/bloc/events/crud_event.dart';
import 'package:secand_in_firebase/bloc/states/crud_state.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  late ImagePicker _imagePicker;
  XFile? _pickedImage;

  double? _progressValue = 0;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        actions: [
          Icon(Icons.camera),
          SizedBox(
            width: 8,
          )
        ],
      ),
      body: BlocListener<ImagesBloc, CrudState>(
        listenWhen: (previous, current) =>
            current is CrudProcess &&
            current.processState == ProcessState.create,
        listener: (context, state) {
          state as CrudProcess;
          setState(() {
            _progressValue = state.success ? 1 : 0;
          });
          showSnackBar(message: state.message, error: !state.success);
          print('snackbar image- ${state.message}');
        },
        child: Column(
          children: [
            LinearProgressIndicator(
              minHeight: 10,
              color: Colors.green,
              value: _progressValue,
            ),
            _pickedImage == null
                ? Expanded(
              child: Center(
                child: IconButton(
                  onPressed: () {
                    _pickerImage();
                  },
                  icon: Icon(
                    Icons.camera_enhance,
                    size: 32,
                  ),
                ),
              ),
            )
                : Expanded(child: Image.file(File(_pickedImage!.path))),
            ElevatedButton.icon(
              onPressed: () async {
                await preformUpload();
              },
              icon: Icon(Icons.upload),
              label: Text('Upload'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickerImage() async {
    XFile? _selectedImage = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 80);
    if (_selectedImage != null) {
      setState(() {
        _pickedImage = _selectedImage;
      });
    }
  }

  Future<void> preformUpload() async {
    if (_checkData()) {
      await uploadImage();
      print('is thire any image? ${_pickedImage}');
    }
  }

  bool _checkData() {
    if (_pickedImage != null) {
      return true;
    }
    showSnackBar(message: 'Upload image failed',error: true);
    return false;
  }
  void showSnackBar({required String message, bool error=false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error? Colors.red: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  Future<void> uploadImage() async {
    setState(() {
      _progressValue = null;
    });
    BlocProvider.of<ImagesBloc>(context)
        .add(CreateEvent(File(_pickedImage!.path)));
  }
}
