import 'dart:math';

import 'package:flutter/material.dart';
import '../../model/roomShort.dart';

class RoomListTile extends StatefulWidget {
  final RoomShort room;
  final bool disabled;

  RoomListTile({
    required this.room,
    required this.disabled,
  });

  @override
  State<RoomListTile> createState() => _RoomListTileState();
}

class _RoomListTileState extends State<RoomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        height: 45,
        child: ElevatedButton(
          onPressed: widget.disabled == true ? () {} : null,
          child: Text(
            widget.room.roomName,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 1.0),
            alignment: Alignment.centerLeft,
            backgroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return Color.fromRGBO(86, 86, 86, 1);
              }
              return Colors.white;
            }),
            overlayColor: MaterialStateColor.resolveWith(
              (states) => Color.fromRGBO(86, 86, 86, 1),
            ),
            foregroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.pressed) ||
                  states.contains(MaterialState.disabled)) {
                return Colors.white;
              }
              return Colors.black;
            }),
          ),
        ),
      ),
    );
  }
}
