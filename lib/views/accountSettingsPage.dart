import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_clientx/views/login.dart';
import '../widgets/appbar/appbar.dart';
import '../widgets/appbar/appbarButton.dart';

class AccountSettingsPage extends StatefulWidget {
  final User user;

  const AccountSettingsPage({
    required this.user,
  });

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor(
        titleStr: "Account",
        context: context,
        leftNaviBarButton: AppBarButton(
          buttonCallBack: () => Navigator.of(context).pop(),
          buttonIcon: const Icon(Icons.arrow_back),
          context: context,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: ListView(
          children: [
            ListTile(
              trailing: const Icon(Icons.chevron_right),
              title: const Text("Log out"),
              onTap: () async {
                final navigator = Navigator.of(context);
                await FirebaseAuth.instance.signOut();
                navigator.pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginPage()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
