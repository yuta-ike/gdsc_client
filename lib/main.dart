import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import './mainTheme.dart';
import './views/homePage.dart';
import './views/editRoomPage.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  print('CHECK IF ARCORE IS AVAILABLE');
  print(await ArCoreController.checkArCoreAvailability());

  print('\nCHECK IF AR SERVICES IS INSTALLED');
  print(await ArCoreController.checkIsArCoreInstalled());

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
