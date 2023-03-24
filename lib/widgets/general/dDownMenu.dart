import 'package:flutter/material.dart';

class DDownMenu extends StatelessWidget {
  final List<String> choices;
  final String title;
  final int? defaultValueIdx;
  final double? fieldWidth;

  DDownMenu({
    required this.choices,
    required this.title,
    this.defaultValueIdx,
    this.fieldWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fieldWidth,
      child: DropdownButtonFormField(
        value: defaultValueIdx == null ||
                defaultValueIdx! < 0 ||
                defaultValueIdx! >= choices.length
            ? choices[0]
            : choices[defaultValueIdx!],
        decoration: InputDecoration(
            label: Text(title),
            labelStyle: TextStyle(
              fontSize: 12,
            )),
        items: choices
            .map(
              (value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                value: value,
              ),
            )
            .toList(),
        onChanged: (e) {},
      ),
    );
  }
}
