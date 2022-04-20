import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';

class FirebaseStorage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile({
    required String fileName,
    required String filePath,
  }) async {
    File file = File(filePath);

    try {
      await storage.ref('images/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }
}
