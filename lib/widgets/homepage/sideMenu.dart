import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/room.dart';
import '../../model/roomShort.dart';
import '../../views/editRoomPage.dart';
import '../../widgets/general/tButton.dart';
import '../../widgets/sidemenu/roomListView.dart';
import '../../widgets/sidemenu/userProfileCard.dart';

class SideMenu extends StatefulWidget {
  final User user;
  final List<RoomShort> roomList;
  String currRoomId;
  final Function listTileOnTapCallback;
  final Function roomCreateCallback;

  SideMenu({
    super.key,
    required this.user,
    required this.roomList,
    required this.currRoomId,
    required this.listTileOnTapCallback,
    required this.roomCreateCallback,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  changeRoom(String roomIdOnTapped) {
    setState(() {
      widget.currRoomId = roomIdOnTapped;
    });
    widget.listTileOnTapCallback(roomIdOnTapped);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserProfileCard(user: widget.user),
          Expanded(
            child: Container(
              child: RoomListView(
                currRoomId: widget.currRoomId,
                roomListShort: widget.roomList,
                listTileOnTapCallback: changeRoom,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: tButton(
                  buttonText: "Add Room",
                  tButtonPressedCallBack: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return EditRoomPage(
                            dataChangedCallback: (String newRoomId) {
                              widget.roomCreateCallback(newRoomId);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    );
                  },
                  buttonWidth: 150,
                  additionalButtonIcon: Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
