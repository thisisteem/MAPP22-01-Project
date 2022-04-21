import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser!;

String checkingDocumentIdConverter({
  required String email,
  required String eventTitle,
  required String bib,
}) {
  String newEventTitle = eventTitle.replaceAll(' ', '_');

  String result = '${email}_${newEventTitle}_$bib';
  return result;
}
