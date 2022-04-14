import 'package:flutter/material.dart';
import 'package:virtual_run_kku/models/profile.dart';

import '../utils/constants/colors.dart';
import '../widgets/custom_profile_image_picker.dart';
import '../widgets/custom_textformfield.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _profileNameController = TextEditingController();

  final ProfileModel profile = ProfileModel(
      id: 1,
      name: 'Eleanor Pena',
      urlImage:
          'https://images.unsplash.com/photo-1566492031773-4f4e44671857?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80');

  @override
  void initState() {
    _profileNameController.text = profile.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: colorWhite,
      appBar: AppBar(
        title: const Text('ตั้งค่าโปรไฟล์'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        color: colorWhite,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colorGrey,
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ยกเลิก',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: colorWhite,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colorPrimary,
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      debugPrint('ชื่อโปรไฟล์: ${_profileNameController.text}');
                    }
                  },
                  child: Text(
                    'บันทึก',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: colorWhite,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildProfileName(),
                const SizedBox(height: 20),
                buildProfileImage(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildProfileName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          textLabel: 'ชื่อโปรไฟล์',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: _profileNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอกชื่อโปรไฟล์';
            }
            return null;
          },
          onSaved: (value) {
            _profileNameController.text = value.toString().trim();
          },
        ),
      ],
    );
  }

  Widget buildProfileImage() {
    return CustomProfileImagePicker(
      urlImage: profile.urlImage,
    );
  }
}
