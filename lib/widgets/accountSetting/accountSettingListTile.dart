import 'package:flutter/material.dart';

class AccountSettingListTile extends StatelessWidget {
  final String title;
  final VoidCallback buttonOnPressedCallBack;

  AccountSettingListTile({
    required this.title,
    required this.buttonOnPressedCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonOnPressedCallBack,
      child: Text(title),
    );
  }
}
