import 'package:flutter/material.dart';
import '../../model/room.dart';

class RoomInfoCard extends StatelessWidget {
  final Room room;

  // style property
  final cardBKColor = Colors.white;

  RoomInfoCard({
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Container(
        child: Card(
          child: Column(
            children: [
              Text("city: ${room.roomCity}"),
              Text("household: ${room.householdList.length.toString()}"),
              Text("needWheelChair: ${room.needWheelChair ? "Yes" : "No"}"),
            ],
          ),
          color: cardBKColor,
        ),
        height: 250,
      ),
    );
  }
}
