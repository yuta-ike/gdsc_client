import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
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

  print('CHECK IF ARCORE IS AVAILABLE');
  print(await ArCoreController.checkArCoreAvailability());

  print('\nCHECK IF AR SERVICES IS INSTALLED');
  print(await ArCoreController.checkIsArCoreInstalled());

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
