import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secand_in_firebase/firebase/fb_auth_controller.dart';
import 'package:secand_in_firebase/firebase/fb_firestore_controller.dart';
import 'package:secand_in_firebase/models/note.dart';
import 'package:secand_in_firebase/screens/app/add_note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes Screen'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNote(),
                    ));
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/images_screen');
              },
              icon: Icon(Icons.image)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Are you sour? '),
                      actions: [
                        TextButton(onPressed: (){
                          FbAuthController().signOut();
                          Navigator.pushReplacementNamed(context, '/login_screen');
                        }, child: Text('Yas')),
                        TextButton(onPressed: (){Navigator.pop(context);}, child: Text('No')),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout)),

        ],
      ),
      body: StreamBuilder<QuerySnapshot<Note>>(
          stream: FbFirestoreController().readNotes(),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.info),
                    title: Text(snapshot.data!.docs[index]
                        .data()
                        .title),
                    subtitle: Text(snapshot.data!.docs[index]
                        .data()
                        .info),
                    trailing: IconButton(onPressed: () {
                      deleteNote(path: snapshot.data!.docs[index].id);
                    }, icon: Icon(Icons.delete)),
                    onTap: () =>_preformUpdate(snapshot.data!.docs[index]),
                  );
                },
              );
            } else {
              return Center(child: Text('No Data', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),),);
            }
          }),
    );
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<bool> deleteNote({required String path}) async {
    bool deleted = await FbFirestoreController().deleteNote(path: path);
    showSnackBar(message: 'Deleted Successfully');
    return deleted;
  }


  void _preformUpdate(QueryDocumentSnapshot<Note> queryDocumentSnapshot) {
    Note note = queryDocumentSnapshot.data();
    note.path = queryDocumentSnapshot.id;
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddNote(note: note),),);
  }
}
