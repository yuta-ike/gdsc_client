import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_client/request.dart';
import 'package:gdsc_client/utils/login.dart';
import 'package:gdsc_client/widgets/general/eButton.dart';

import 'homePage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 0,
            ),
            const Text(
              "Awesome Service Name",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            eButton(
              buttonPressedVoidBack: () async {
                final navigator = Navigator.of(context);
                await logInWithGoogle();
                if (FirebaseAuth.instance.currentUser != null) {
                  navigator.pushReplacement(MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomePage()));
                }
              },
              buttonText: 'Login with Google',
            )
          ],
        ),
      ),
    );
  }
}
