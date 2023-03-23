import 'package:flutter/material.dart';
import '../../model/room.dart';
import '../../model/roomShort.dart';
import '../../widgets/sidemenu/roomListTile.dart';

class RoomListView extends StatefulWidget {
  final List<RoomShort> roomListShort;
  final Room currRoom;

  RoomListView({
    required this.roomListShort,
    required this.currRoom,
  });

  @override
  State<RoomListView> createState() => _RoomListViewState();
}

class _RoomListViewState extends State<RoomListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return RoomListTile(
            room: widget.roomListShort[index],
            disabled: widget.currRoom.id == widget.roomListShort[index].id
                ? false
                : true,
          );
        },
        itemCount: widget.roomListShort.length,
      ),
    );
  }
}
