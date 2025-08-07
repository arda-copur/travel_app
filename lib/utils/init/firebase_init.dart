import 'package:firebase_core/firebase_core.dart';

//Firebase initialization for the app
Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}
