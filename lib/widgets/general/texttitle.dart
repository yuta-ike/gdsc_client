import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String titleText;
  final String? subTitleText;

  TextTitle({
    required this.titleText,
    this.subTitleText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            titleText,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        subTitleText != null
            ? Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      subTitleText!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
