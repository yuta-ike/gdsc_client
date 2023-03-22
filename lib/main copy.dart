import 'package:flutter/material.dart';
import './mainTheme.dart';
import './views/homePage.dart';
import './views/editRoomPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GDSC Project",
      theme: MainTheme().materialTheme,
      // theme: ThemeData(primaryColor: Colors.red),
      home: HomePage(),
    );
  }
}
