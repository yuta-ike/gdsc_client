import 'package:flutter/material.dart';
import 'package:gdsc_client/views/login.dart';
import 'package:gdsc_client/widgets/general/eButton.dart';

class GoToLoginPage extends StatefulWidget {
  const GoToLoginPage({super.key});

  @override
  State<GoToLoginPage> createState() => _GoToLoginPageState();
}

class _GoToLoginPageState extends State<GoToLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: eButton(
            buttonPressedVoidBack: () => Navigator.of(context)
                .pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginPage()),
                    (route) => false),
            buttonText: "Go to login"),
      ),
    );
  }
}
