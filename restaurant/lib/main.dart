import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/homepage.widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDw9onzTUaI7kJee7UpxGi2Tqbvk-huswo",
        appId: "1:678909221405:web:d5e62c99327d8fec7484f4",
        messagingSenderId: "678909221405",
        projectId: "tp-flutter-e743b"
    )
  );
  runApp(const MyHomePage());
}