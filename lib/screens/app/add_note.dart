import 'package:flutter/material.dart';
import 'package:secand_in_firebase/firebase/fb_firestore_controller.dart';
import 'package:secand_in_firebase/models/note.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key, this.note}) : super(key: key);
  final Note? note;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  // Note note=<Note>[];
  late TextEditingController _titleTextEditingController;
  late TextEditingController _infoTextEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextEditingController =
        TextEditingController(text: widget.note?.title);
    _infoTextEditingController = TextEditingController(text: widget.note?.info);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleTextEditingController.dispose();
    _infoTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 24),
        child: ListView(
          children: [
            TextField(
              controller: _titleTextEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Title',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _infoTextEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'info',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                preformProcess();
              },
              child: Text('Add Note'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 46),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void preformProcess() {
    if (checkData()) {
      AddNoteData();
    }
  }

  bool checkData() {
    if (_titleTextEditingController.text.isNotEmpty &&
        _infoTextEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(message: 'Enter required Data', error: true);
    return false;
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> AddNoteData() async {
    bool status = widget.note == null
        ? await FbFirestoreController().create(note: note)
        : await FbFirestoreController().updateNote(updatedNote: note);


     if(status){
       widget.note == null ? Navigator.pop(context) : clear();
     }
      widget.note == null
          ? showSnackBar(
              message:  'created successfully' )
          : showSnackBar(
              message:'updated successfully');

  }

  Note get note {
    Note note = Note();
    if (widget.note != null) {
      note.path = widget.note!.path;
    }
    note.title = _titleTextEditingController.text;
    note.info = _infoTextEditingController.text;
    return note;
  }

  void clear() {
    _titleTextEditingController.text = '';
    _infoTextEditingController.text = '';
  }
}
