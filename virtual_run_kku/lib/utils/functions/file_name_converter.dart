import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

final user = FirebaseAuth.instance.currentUser!;

String fileNameConvert({required String title, required String oldName}) {
  String newName = '';
  title = title.replaceAll(' ', '_');
  String displayName = user.displayName!.replaceAll(' ', '_');
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);

  String extension = oldName.split('.')[1];

  newName = '${displayName}_${title}_$formattedDate.$extension';
  print(newName);
  return newName;
}
