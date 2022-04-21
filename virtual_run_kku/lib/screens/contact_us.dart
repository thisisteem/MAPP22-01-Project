import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/my_constants.dart';
import '../widgets/custom_textformfield.dart';
import '../widgets/toast.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _bugReportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: colorWhite,
      appBar: subAppBar("ติดต่อเรา"),
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
                    // if (_formKey.currentState!.validate()) {
                    //   _formKey.currentState!.save();
                    //   print(_bugReportController);
                    // }
                    toastSuccess(msg: 'ส่งการรายงานสำเร็จ!');
                    Navigator.pop(context);
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
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.facebook,
                color: Colors.blue,
                size: 40,
              ),
              title: Text(
                'Teem Chakphet',
                style: MyConstant.h1Style(colorSecondary),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Image.asset(MyConstant.instaIcon),
                maxRadius: 20,
              ),
              title: Text(
                'Teem Chakphet',
                style: MyConstant.h1Style(colorSecondary),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.contact_phone,
                size: 40,
                color: colorPrimary,
              ),
              title: Text(
                '084-798-8456',
                style: MyConstant.h1Style(colorSecondary),
              ),
            ),
            const Center(
              child: Text(
                'หรือ',
              ),
            ),
            CustomTextFormField(
              numMaxLine: 3,
              textLabel: 'แจ้งปัญหา (Optional)',
              isRequired: true,
              controller: _bugReportController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'โปรดกรอกปัญหาที่ท่านพบ';
                }
                return null;
              },
              onSaved: (value) {
                //_profileNameController.text = value.toString().trim();
              },
            ),
          ],
        ),
      ),
    );
  }
}

AppBar subAppBar(String title) => AppBar(
      foregroundColor: colorPrimary,
      centerTitle: true,
      title: Text(
        title,
        style: MyConstant.h1Style(colorPrimary),
      ),
      elevation: 1,
      backgroundColor: colorWhite,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: colorWhite,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    );
