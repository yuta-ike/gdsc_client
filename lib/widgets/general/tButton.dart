import 'package:flutter/material.dart';

class tButton extends StatelessWidget {
  final String buttonText;
  final double buttonWidth;
  final VoidCallback tButtonPressedCallBack;
  final Icon? additionalButtonIcon;

  final TextStyle textStyle = TextStyle(
    decoration: TextDecoration.underline,
    color: Colors.black,
    fontSize: 17,
  );

  final ButtonStyle buttonStyle = ButtonStyle(
    overlayColor: MaterialStateProperty.resolveWith(
      (_) => Color.fromRGBO(66, 66, 66, 0.2),
    ),
  );

  tButton({
    required this.buttonText,
    required this.tButtonPressedCallBack,
    required this.buttonWidth,
    this.additionalButtonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        width: buttonWidth,
        child: TextButton(
          onPressed: tButtonPressedCallBack,
          style: buttonStyle,
          child: additionalButtonIcon == null
              ? Text(
                  buttonText,
                  style: textStyle,
                )
              : Row(
                  children: [
                    Text(
                      buttonText,
                      style: textStyle,
                    ),
                    Icon(
                      Icons.add,
                      color: Color.fromRGBO(66, 66, 66, 1),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
