import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser!;

String checkingDocumentIdConverter({
  required String displayName,
  required String eventTitle,
  required String bib,
}) {
  String newDisplayName = displayName.replaceAll(' ', '_');
  String newEventTitle = eventTitle.replaceAll(' ', '_');

  String result = '${newDisplayName}_${newEventTitle}_$bib';
  return result;
}
