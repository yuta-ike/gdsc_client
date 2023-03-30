import 'package:flutter/material.dart';
import '../../widgets/general/dDownMenu.dart';
import '../../model/household.dart';
import './inputTextField.dart';

class HouseHoldCard extends StatefulWidget {
  final Household? household;
  final Function heightOnChangedCallback;
  final Function ageOnChangedCallback;
  final Function wheelChairOnSavedCallback;

  HouseHoldCard({
    required this.household,
    required this.heightOnChangedCallback,
    required this.ageOnChangedCallback,
    required this.wheelChairOnSavedCallback,
  });

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
  TextEditingController _ageInputController = TextEditingController();
  TextEditingController _heightInputController = TextEditingController();
  int _currDDownMenuIdx = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _heightInputController.text = widget.household!.height.toString();
      _ageInputController.text = widget.household!.age.toString();
      _currDDownMenuIdx = widget.household!.needWheelChair == false ? 1 : 0;
    });
  }

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
                    hintText: "0",
                    label: "Age",
                    textInputController: _ageInputController,
                    validator: widget._numInputValidator,
                    textInputType: TextInputType.number,
                    fieldLength: 40,
                    onChangedCallBack: widget.ageOnChangedCallback,
                  ),
                  SizedBox(width: 20),
                  InputTextField(
                    hintText: "0",
                    label: "Height",
                    textInputController: _heightInputController,
                    validator: widget._numInputValidator,
                    textInputType: TextInputType.number,
                    fieldLength: 60,
                    unitText: "cm",
                    onChangedCallBack: widget.heightOnChangedCallback,
                  )
                ],
              ),
              DDownMenu(
                onChangedCallback: widget.wheelChairOnSavedCallback,
                choices: ["Yes", "No"],
                title: "Wheel Chair Usage",
                fieldWidth: 120,
                defaultValueIdx: _currDDownMenuIdx,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
