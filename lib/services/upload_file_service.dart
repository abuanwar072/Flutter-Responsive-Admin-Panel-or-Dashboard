import 'dart:io';

import 'package:admin/config/helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class UploadFileService {
  // CLASS NAME FOR DEBUGGING PURPOSES IN CAPITAL CASE
  static const String className = 'EmployeesServices';

  // CREATE AN INSTANCE OF FIREBASE STORAGE CLASS
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // UPLOAD FILE TO FIREBASE
  Future<String?> uploadFile(File file, String fileName) async {
    final uniqueName = const Uuid().v4();
    final path = 'resumes/$uniqueName/$fileName';
    try {
      Reference storageReference = _storage.ref().child(path);
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } on SocketException {
      if (kDebugMode) Helper.logger.e('$className: SocketException');
      return null;
    } on Exception {
      if (kDebugMode) Helper.logger.e('$className: Exception');
      return null;
    }
  }

  // UPLOAD AN IMAGE TO FIREBASE STORAGE
  Future<String?> uploadImage(File file) async {
    final uniqueName = const Uuid().v4();
    final path = 'images/$uniqueName/${basename(file.path)}';

    Helper.logger.i('$className: Uploading image to $path');

    try {
      Reference storageReference = _storage.ref().child(path);
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } on SocketException {
      if (kDebugMode) Helper.logger.e('$className: SocketException');
      return null;
    } on Exception {
      if (kDebugMode) Helper.logger.e('$className: Exception');
      return null;
    }
  }
}
