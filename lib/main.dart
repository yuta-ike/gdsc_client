import 'package:flutter/material.dart';
import 'package:gdsc_clientx/views/login.dart';
import './mainTheme.dart';
import './views/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GDSC Project",
      theme: MainTheme().materialTheme,
      // theme: ThemeData(primaryColor: Colors.red),
      home: const LoginPage(),
    );
  }
}
