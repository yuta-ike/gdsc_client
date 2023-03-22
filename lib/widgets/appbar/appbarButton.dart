import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final VoidCallback buttonCallBack;
  final Icon buttonIcon;
  final BuildContext context;

  AppBarButton({
    required this.buttonCallBack,
    required this.buttonIcon,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: buttonCallBack,
      icon: buttonIcon,
    );
  }
}
