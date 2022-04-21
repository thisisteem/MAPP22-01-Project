import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_run_kku/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class CustomProfileImagePicker extends StatefulWidget {
  final String? urlImage;

  const CustomProfileImagePicker({
    Key? key,
    this.urlImage,
  }) : super(key: key);

  @override
  _CustomProfileImagePickerState createState() =>
      _CustomProfileImagePickerState();
}

class _CustomProfileImagePickerState extends State<CustomProfileImagePicker> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<void> _fileFromImageUrl(String urlImage) async {
    final response = await http.get(Uri.parse(urlImage));

    // Get the image name
    final imageName = path.basename(urlImage);
    // Get the document directory path
    final appDir = await path_provider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later
    final localPath = path.join(appDir.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);

    setState(() {
      image = imageFile;
    });
  }

  @override
  void initState() {
    if (widget.urlImage != null) _fileFromImageUrl(widget.urlImage!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => cameraSelect(context),
      child: Container(
        height: image == null ? 250 : null,
        width: double.infinity,
        child: image != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(80), // Image radius
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'คลิกอีกครั้งเพื่อเปลี่ยนรูป',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: colorSecondary),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'เพิ่มรูปภาพ',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: colorPrimary),
                  )
                ],
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: colorGrey, spreadRadius: 1),
          ],
        ),
      ),
    );
  }

  Future<dynamic> cameraSelect(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(
              'เปิดกล้อง',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            onTap: () => Navigator.of(context).pop(
              pickImage(ImageSource.camera),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: Text(
              'เลือกรูป',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            onTap: () => Navigator.of(context).pop(
              pickImage(ImageSource.gallery),
            ),
          ),
        ],
      ),
    );
  }
}
