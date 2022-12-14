import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FbStorageController {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  UploadTask createImage({required File file}) {
    UploadTask uploadTask = _firebaseStorage
        .ref('images/image_${DateTime
        .now()
        .millisecondsSinceEpoch}')
        .putFile(file);
    return uploadTask;
  }

  Future<List<Reference>> readImages() async {
    ListResult listResult = await _firebaseStorage.ref('images').listAll();
    if (listResult.items.isNotEmpty) {
      return listResult.items;
    }
    return [];
  }

  Future<bool> deleteImage({required String path}) async {
    return await _firebaseStorage.ref(path).delete().then((value) => true).onError((error,
        stackTrace) => false);
  }
//  CRUD

}
