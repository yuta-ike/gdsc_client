import 'package:flutter/material.dart';

class HouseholdCardButtons extends StatelessWidget {
  final VoidCallback addHouseholdCallBack = () {};
  final VoidCallback removeHouseholdCallBack = () {};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Row(
        children: [
          IconButton(
            onPressed: addHouseholdCallBack,
            icon: Icon(Icons.add_circle),
          ),
          IconButton(
            onPressed: removeHouseholdCallBack,
            icon: Icon(Icons.remove_circle),
          ),
        ],
      ),
    );
  }
}
