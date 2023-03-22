import 'package:flutter/material.dart';

class eButton extends StatelessWidget {
  final VoidCallback buttonPressedVoidBack;
  final String buttonText;

  // style Property
  final Color eButtonBkColor = Colors.black;
  final Color eButtonTColor = Colors.white;
  final double eButtonTextFontSize = 20;

  eButton({
    required this.buttonPressedVoidBack,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        height: 50,
        child: ElevatedButton(
          onPressed: buttonPressedVoidBack,
          child: Text(
            buttonText,
            style: TextStyle(),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => eButtonBkColor),
            alignment: Alignment.center,
            textStyle: MaterialStateTextStyle.resolveWith(
              (states) => TextStyle(
                fontSize: eButtonTextFontSize,
                color: eButtonTColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
