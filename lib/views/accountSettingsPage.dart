import 'package:flutter/material.dart';
import '../model/user.dart';
import '../widgets/appbar/appbar.dart';
import '../widgets/appbar/appbarButton.dart';

class AccountSettingsPage extends StatefulWidget {
  final User user;

  AccountSettingsPage({
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
          buttonIcon: Icon(Icons.arrow_back),
          context: context,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {},
      ),
    );
  }
}
