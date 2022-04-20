import 'package:flutter/material.dart';

class FileUploadProvider extends ChangeNotifier {
  String fileName;
  String filePath;

  FileUploadProvider({
    this.fileName = '',
    this.filePath = '',
  });

  setFileName(String newFileName) {
    fileName = newFileName;
    // notifyListeners();
  }

  setFilePath(String newFilePath) {
    filePath = newFilePath;
    // notifyListeners();
  }
}
