import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_run_kku/utils/constants/my_constants.dart';

import '../utils/constants/colors.dart';
import 'contact_us.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: colorWhite,
      appBar: subAppBar("ติดต่อเรา"),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            textDirection: TextDirection.ltr,
            children: [
              buildProfileName(),
              buildProfileImage(),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileName() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'ชื่อโปรไฟล์',
            style: MyConstant.h3Style(colorSecondary),
          ),
        ),
        const TextField(
          maxLength: 15,
          obscureText: false,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
            hintText: 'ใส่ชื่อโปรไฟล์ที่ต้องการ',
          ),
        )
      ],
    );
  }

  Widget buildProfileImage() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Text(
            'รูปโปรไฟล์',
            style: MyConstant.h3Style(colorSecondary),
          ),
        ),
        InkWell(
          onTap: (() => pickImage()),
          child: Card(
            margin: EdgeInsets.zero,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                color: Colors.black,
                width: 0.35,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  image != null
                      ? Image.file(
                          image!,
                          width: 100,
                          height: 100,
                        )
                      : Image(
                          image: AssetImage(MyConstant.avatarIcon),
                          width: 100,
                          height: 100,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    image != null ? 'เปลี่ยนรูปภาพ' : 'เพิ่มรูปภาพ',
                    style: MyConstant.h3Style(colorPrimary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: image != null ? colorPrimary : colorGrey,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'เสร็จสิ้น',
          style: MyConstant.h3Style(colorWhite),
        ),
      ),
    );
  }
}
