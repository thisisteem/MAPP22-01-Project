import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/constants/my_constants.dart';

class SendResult extends StatefulWidget {
  const SendResult({Key? key}) : super(key: key);

  @override
  _SendResultState createState() => _SendResultState();
}

class _SendResultState extends State<SendResult> {
  File? image;

  Future pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      backgroundColor: MyConstant.white,
      appBar: MyConstant.appBar(MyConstant.titleSendResult, false),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        children: [
          buildDate(),
          const SizedBox(height: 20),
          buildDistance(),
          const SizedBox(height: 20),
          buildTime(),
          const SizedBox(height: 20),
          buildImagePicker(),
          const SizedBox(height: 20),
          buildButton()
        ],
      ),
    );
  }

  Widget buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelStyle: MyConstant.h3Style(MyConstant.secondary),
            labelText: 'วันทีและเวลา',
            suffixIcon: const Icon(Icons.calendar_month),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 2.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade900),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 2.0,
            ),
          ),
        )
      ],
    );
  }

  Widget buildDistance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelStyle: MyConstant.h3Style(MyConstant.secondary),
            labelText: 'ระยะทาง (km)',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 2.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade900),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 2.0,
            ),
          ),
        )
      ],
    );
  }

  Widget buildTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelStyle: MyConstant.h3Style(MyConstant.secondary),
            labelText: 'ระยะเวลา',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 2.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade900),
              borderRadius: BorderRadius.circular(10),
              gapPadding: 2.0,
            ),
          ),
        )
      ],
    );
  }

  Widget buildImagePicker() {
    return InkWell(
      onTap: () => pickImage(context),
      child: Container(
        height: 250,
        child: image != null
            ? Image.file(
                image!,
                fit: BoxFit.contain,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.grey.shade700,
                  ),
                  Text(
                    'เพิ่มรูปภาพ',
                    style: MyConstant.h3Style(Colors.grey.shade700),
                  )
                ],
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, spreadRadius: 1),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        minimumSize: const Size.fromHeight(50), // NEW
      ),
      onPressed: () {},
      child: Text(
        'ส่งผลการวิ่ง',
        style: MyConstant.h2Style(MyConstant.white),
      ),
    );
  }
}
