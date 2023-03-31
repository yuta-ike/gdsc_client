import 'package:flutter/material.dart';

class DDownMenu extends StatefulWidget {
  final List<String> choices;
  final String title;
  final int? defaultValueIdx;
  final double? fieldWidth;
  final Function onChangedCallback;

  DDownMenu({
    required this.choices,
    required this.title,
    required this.onChangedCallback,
    this.defaultValueIdx,
    this.fieldWidth,
  });

  @override
  State<DDownMenu> createState() => _DDownMenuState();
}

class _DDownMenuState extends State<DDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.fieldWidth,
      child: DropdownButtonFormField(
        value: widget.defaultValueIdx == null ||
                widget.defaultValueIdx! < 0 ||
                widget.defaultValueIdx! >= widget.choices.length
            ? widget.choices[0]
            : widget.choices[widget.defaultValueIdx!],
        decoration: InputDecoration(
            label: Text(widget.title),
            labelStyle: TextStyle(
              fontSize: 12,
            )),
        items: widget.choices
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
        onChanged: (newValue) {
          print("saved");
          widget.onChangedCallback(newValue);
        },
      ),
    );
  }
}
