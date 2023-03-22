import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String label;
  // final String? hint;
  final TextEditingController textInputController;
  final Function validator;
  final double? fieldLength;
  final TextInputType? textInputType;
  final String? hintText;
  final String? unitText;

  InputTextField({
    required this.label,
    required this.textInputController,
    required this.validator,
    this.fieldLength,
    this.textInputType,
    this.hintText,
    this.unitText,
    // this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fieldLength == null ? double.infinity : fieldLength!,
      child: TextFormField(
        keyboardType:
            textInputType == null ? TextInputType.text : textInputType!,
        validator: (value) => validator(value),
        controller: textInputController,
        style: TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          suffix: unitText == null
              ? null
              : Text(
                  unitText!,
                  style: TextStyle(fontSize: 10),
                ),
          hintText: hintText == null ? "" : hintText,
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
