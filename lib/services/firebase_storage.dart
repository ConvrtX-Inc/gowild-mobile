import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FBStorage {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String?> uploadPicture(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      final TaskSnapshot storageRef =
          await _storage.ref('profile_pics/$fileName').putFile(file);

      return (await storageRef.ref.getDownloadURL()).toString();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
