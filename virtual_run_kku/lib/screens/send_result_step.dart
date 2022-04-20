import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:provider/provider.dart';
import 'package:virtual_run_kku/models/activity_model.dart';
import 'package:virtual_run_kku/services/firestore_database.dart';
import 'package:virtual_run_kku/widgets/toast.dart';

import '../providers/file_upload_provider.dart';
import '../utils/constants/colors.dart';
import '../utils/functions/file_name_converter.dart';
import '../utils/functions/seconds_to_time.dart';
import '../widgets/custom_image_picker.dart';
import '../widgets/custom_textformfield.dart';
import '../widgets/date_picker_custom_textformfield.dart';

class SendResultStep extends StatefulWidget {
  final ActivityModel activity;
  const SendResultStep({Key? key, required this.activity}) : super(key: key);

  @override
  _SendResultStepState createState() => _SendResultStepState();
}

class _SendResultStepState extends State<SendResultStep> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _timeSpendController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final fileUploadProvider = Provider.of<FileUploadProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(widget.activity.title),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colorPrimary,
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: isLoading
              ? null
              : () {
                  // Navigator.pop(context);

                  if (_formKey.currentState!.validate() &&
                      fileUploadProvider.fileName != '' &&
                      fileUploadProvider.filePath != '') {
                    setState(() {
                      isLoading = true;
                    });
                    _formKey.currentState!.save();
                    debugPrint('ระยะทาง: ${_distanceController.text}');
                    debugPrint('เวลาที่ใช้: ${_timeSpendController.text}');
                    debugPrint('วันที่วิ่ง: ${_dateController.text}');
                    debugPrint(
                        'เวลาที่เริ่มวิ่ง: ${_timeStartController.text}');
                    // hhmmssToSeconds(_timeSpendController.text);
                    fileUploadProvider.fileName = fileNameConvert(
                      title: widget.activity.title,
                      oldName: fileUploadProvider.fileName,
                    );
                    sendResult(
                      activityTitle: widget.activity.title,
                      timeSpendInSeconds:
                          hhmmssToSeconds(_timeSpendController.text),
                      distance: double.parse(_distanceController.text),
                      fileName: fileUploadProvider.fileName,
                      context: context,
                    ).then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    });
                  } else {
                    toastError(msg: 'กรุณาใส่ข้อมูลให้ครบ');
                  }
                },
          child: isLoading
              ? SizedBox(
                  child: CircularProgressIndicator(
                    color: colorPrimary,
                  ),
                  height: 20.0,
                  width: 20.0,
                )
              : Text(
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
    return const CustomImagePicker();
  }
}
