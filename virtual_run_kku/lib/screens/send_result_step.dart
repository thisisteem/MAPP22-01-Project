import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';
import '../utils/functions/seconds_to_time.dart';
import '../widgets/custom_textformfield.dart';
import '../widgets/date_picker_custom_textformfield.dart';

class SendResultStep extends StatefulWidget {
  const SendResultStep({Key? key}) : super(key: key);

  @override
  _SendResultStepState createState() => _SendResultStepState();
}

class _SendResultStepState extends State<SendResultStep> {
  File? image;
  bool isSelectedImage = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _timeSpendController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();

  Future pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
      this.image = imageTemporary;
      isSelectedImage = true;
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ส่งผลการวิ่ง'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colorPrimary,
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () {
            // Navigator.pop(context);
            if (_formKey.currentState!.validate() && isSelectedImage) {
              _formKey.currentState!.save();
              debugPrint('ระยะทาง: ${_distanceController.text}');
              debugPrint('เวลาที่ใช้: ${_timeSpendController.text}');
              debugPrint('วันที่วิ่ง: ${_dateController.text}');
              debugPrint('เวลาที่เริ่มวิ่ง: ${_timeStartController.text}');
            }
          },
          child: Text(
            'ส่งผลการวิ่ง',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: colorWhite,
                ),
          ),
        ),
      ),
      backgroundColor: colorWhite,
      body: ListView(
        children: [
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          //   child: Text('test'),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildImagePicker(),
                  const SizedBox(height: 20),
                  buildDistance(),
                  const SizedBox(height: 20),
                  buildTimeSpend(),
                  const SizedBox(height: 20),
                  buildDate(),
                  const SizedBox(height: 20),
                  buildTimeStart(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDistance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          textLabel: 'ระยะทาง (km)',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: _distanceController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอกระยะทาง';
            }
            return null;
          },
          onSaved: (value) {
            _distanceController.text = value.toString().trim();
          },
        ),
      ],
    );
  }

  Widget buildTimeSpend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DatePickerCustomTextFormField(
          textLabel: 'เวลาที่ใช้ (ชั่วโมง)',
          placeholder: '0:00:00',
          suffixIcon: Icons.timer_outlined,
          isRequired: true,
          controller: _timeSpendController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอกเวลาที่ใช้';
            }
            return null;
          },
          onTap: () async {
            await DatePicker.showTimePicker(
              context,
              showTitleActions: true,
              // currentTime: _dateController.text;
              onConfirm: (date) {
                _timeSpendController.text =
                    '${date.hour}:${addZeroToTime(date.minute)}:${addZeroToTime(date.second)}';
                // hhmmssToSeconds(_timeSpendController.text);
              },
              currentTime: DateTime(DateTime.now().year + 543,
                  DateTime.now().month, DateTime.now().day),
              locale: LocaleType.th,
            );
          },
        ),
      ],
    );
  }

  Widget buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DatePickerCustomTextFormField(
          textLabel: 'วันที่วิ่ง',
          placeholder: 'วว/ดด/ปปปป',
          suffixIcon: Icons.insert_invitation,
          isRequired: true,
          controller: _dateController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอกวันที่วิ่ง';
            }
            return null;
          },
          onTap: () async {
            await DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              minTime: DateTime(DateTime.now().year + 443),
              maxTime: DateTime(DateTime.now().year + 543, DateTime.now().month,
                  DateTime.now().day),
              onConfirm: (date) {
                _dateController.text = '${date.day}/${date.month}/${date.year}';
              },
              currentTime: DateTime(DateTime.now().year + 543,
                  DateTime.now().month, DateTime.now().day),
              locale: LocaleType.th,
            );
          },
        ),
      ],
    );
  }

  Widget buildTimeStart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DatePickerCustomTextFormField(
          textLabel: 'เวลาที่เริ่มวิ่ง (น.)',
          placeholder: '0:00:00',
          suffixIcon: Icons.access_time,
          isRequired: true,
          controller: _timeStartController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอกเวลาที่เริ่มวิ่ง';
            }
            return null;
          },
          onTap: () async {
            await DatePicker.showTimePicker(
              context,
              showTitleActions: true,
              showSecondsColumn: false,
              // currentTime: _dateController.text;
              onConfirm: (date) {
                _timeStartController.text =
                    '${date.hour}:${addZeroToTime(date.minute)}';
              },
              currentTime: DateTime(DateTime.now().year + 543,
                  DateTime.now().month, DateTime.now().day),
              locale: LocaleType.th,
            );
          },
        ),
      ],
    );
  }

  Widget buildImagePicker() {
    return InkWell(
      onTap: () => pickImage(context),
      child: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.file(
                image!,
                fit: BoxFit.contain,
              ),
            )
          : Container(
              height: 250,
              width: double.infinity,
              child: Column(
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
}
