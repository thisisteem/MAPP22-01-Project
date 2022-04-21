import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:virtual_run_kku/models/news_model.dart';
import 'package:virtual_run_kku/services/firestore_database.dart';
import 'package:intl/intl.dart';
import '../utils/constants/colors.dart';
import '../utils/functions/seconds_to_time.dart';
import '../widgets/custom_image_picker.dart';
import '../widgets/custom_textformfield.dart';
import '../widgets/date_picker_custom_textformfield.dart';

class CreateNewsPage extends StatefulWidget {
  CreateNewsPage({Key? key}) : super(key: key);

  @override
  State<CreateNewsPage> createState() => _CreateNewsPageState();
}

class _CreateNewsPageState extends State<CreateNewsPage> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _urlImage = TextEditingController();
  final TextEditingController _title = TextEditingController();
  // final TextEditingController _currentBib = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _distance = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สร้างข่าว'),
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
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              createEvent(
                NewsModel(
                    title: _title.text,
                    distance: double.parse(_distance.text),
                    description: _description.text,
                    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    urlImage: '',
                    currentBib: 1000),
              );
              // debugPrint('ระยะทาง: ${_distance.text}');
              // debugPrint('วันที่ลง: ${_date.text}');
              // debugPrint('หัวข้อ: ${_title.text}');
              // debugPrint('รายละเอียด: ${_description.text}');
            }
          },
          child: Text(
            'สร้างข่าว',
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
                  buildTitle(),
                  const SizedBox(height: 20),
                  buildDescription(),
                  const SizedBox(height: 20),
                  buildDistances(),
                  const SizedBox(height: 20),
                  buildDate(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildImagePicker() {
    return const CustomImagePicker();
  }

  Widget buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DatePickerCustomTextFormField(
          textLabel: 'วันที่จัดกิจกรรม',
          placeholder: 'วว/ดด/ปปปป',
          suffixIcon: Icons.insert_invitation,
          isRequired: true,
          controller: _date,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอกวันที่จัดกิจกรรม';
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
                _date.text = '${date.day}/${date.month}/${date.year}';
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

  Widget buildDistances() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          textInputType: TextInputType.number,
          textLabel: 'ระยะทาง',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: _distance,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอกระยะทาง';
            }
            return null;
          },
          onSaved: (value) {
            _distance.text = value.toString().trim();
          },
        ),
      ],
    );
  }

  Widget buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          textLabel: 'หัวข้อข่าว',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: _title,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอกหัวข้อข่าว';
            }
            return null;
          },
          onSaved: (value) {
            _title.text = value.toString().trim();
          },
        ),
      ],
    );
  }

  Widget buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          numMaxLine: 6,
          textLabel: 'รายละเอียดข่าว',
          isRequired: true,
          textInputAction: TextInputAction.next,
          controller: _description,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอกรายละเอียดข่าว';
            }
            return null;
          },
          onSaved: (value) {
            _description.text = value.toString().trim();
          },
        ),
      ],
    );
  }
}
