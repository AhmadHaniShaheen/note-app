import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secand_in_firebase/models/note.dart';

class FbFirestoreController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//  CRUD
  Future<bool> create({required Note note}) async {
    return await _firebaseFirestore
        .collection('Notes')
        .add(note.toMap())
        .then((DocumentReference value) {
      print(value.id);
      return true;
    }).onError((error, stackTrace) => false);
  }

  Future<bool> deleteNote({required String path}) async {
    return await _firebaseFirestore
        .collection('Notes')
        .doc(path)
        .delete()
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  Future<bool> updateNote({required Note updatedNote}) async {
    return await _firebaseFirestore
        .collection('Notes')
        .doc(updatedNote.path)
        .update(updatedNote.toMap())
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }



  Stream<QuerySnapshot<Note>> readNotes( ) async* {
    yield* _firebaseFirestore.collection('Notes').withConverter<Note>(
        fromFirestore: (snapshot, options) => Note.formMap(snapshot.data()!),
        toFirestore: (value, options) => value.toMap()).snapshots();
  }
}
