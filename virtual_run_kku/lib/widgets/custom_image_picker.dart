import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_run_kku/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import '../providers/file_upload_provider.dart';

class CustomImagePicker extends StatefulWidget {
  final String? urlImage;

  const CustomImagePicker({
    Key? key,
    this.urlImage,
  }) : super(key: key);

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? image;
  late String fileName;
  late String filePath;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      fileName = image.name;
      filePath = image.path;

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
    final fileUploadProvider = Provider.of<FileUploadProvider>(context);

    return InkWell(
      onTap: () => cameraSelect(context).then((value) {
        fileUploadProvider.fileName = fileName;
        fileUploadProvider.filePath = filePath;
      }),
      child: Container(
        height: image == null ? 250 : null,
        width: double.infinity,
        child: image != null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Image.file(
                      image!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'คลิกที่รูปอีกครั้งเพื่อเปลี่ยนรูป',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: colorWhite,
                      shadows: <Shadow>[
                        const Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
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
