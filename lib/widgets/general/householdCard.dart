import 'package:flutter/material.dart';
import '../../widgets/general/dDownMenu.dart';
import '../../model/household.dart';
import './inputTextField.dart';

class HouseHoldCard extends StatefulWidget {
  final Household? household;

  HouseHoldCard({this.household});

  TextEditingController get _ageInputController => TextEditingController(
      text: household == null ? "" : household!.age.toString());
  TextEditingController get _heightInputController => TextEditingController(
      text: household == null ? "" : household!.height.toString());

  final Function _numInputValidator = (value) {
    if (value == null || double.tryParse(value) == null) {
      return "Please input a number";
    } else if (double.parse(value) < 0) {
      return "Please input a positive number";
    }
    return null;
  };

  @override
  State<HouseHoldCard> createState() => _HouseHoldCardState();
}

class _HouseHoldCardState extends State<HouseHoldCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Container(
              child: Image.asset('src/img/profileIcon.png'),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  InputTextField(
                    label: "Age",
                    textInputController: widget._ageInputController,
                    validator: widget._numInputValidator,
                    textInputType: TextInputType.number,
                    fieldLength: 40,
                  ),
                  SizedBox(width: 20),
                  InputTextField(
                    label: "Height",
                    textInputController: widget._heightInputController,
                    validator: widget._numInputValidator,
                    textInputType: TextInputType.number,
                    fieldLength: 60,
                    unitText: "cm",
                  )
                ],
              ),
              DDownMenu(
                choices: ["Yes", "No"],
                title: "Wheel Chair Usage",
                fieldWidth: 120,
                defaultValueIdx: widget.household!.needWheelChair ? 0 : 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
