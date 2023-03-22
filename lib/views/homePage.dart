import 'package:flutter/material.dart';
import 'package:gdsc_clientx/views/inspectMainPage.dart';
import 'package:gdsc_clientx/widgets/listTile/warningListTile.dart';
import '../mock.dart';
import '../model/starredList.dart';
import '../widgets/appbar/appbar.dart';
import '../widgets/appbar/appbarButton.dart';
import '../widgets/homepage/roomInfoCard.dart';
import '../model/room.dart';
import '../widgets/general/eButton.dart';
import './editRoomPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VoidCallback _menuButtonCallBack = () {};
  final VoidCallback _listTileEditButtonCallBack = () {};

  final StarredList starredList = Mock.getMockStarredList;

  final Room room = Mock.getSingleRoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor(
        context: context,
        titleStr: room.roomTitle,
        leftNaviBarButton: AppBarButton(
          buttonCallBack: _menuButtonCallBack,
          buttonIcon: Icon(Icons.menu),
          context: context,
        ),
        rightNaviBarButton: AppBarButton(
          buttonCallBack: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return EditRoomPage(
                  currRoom: room,
                );
              },
            ),
          ),
          buttonIcon: Icon(Icons.edit),
          context: context,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return RoomInfoCard(
                room: room,
              );
            } else if (index == 1) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                child: eButton(
                  buttonPressedVoidBack: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return InspectMainPage();
                      },
                    ),
                  ),
                  buttonText: "OPEN CAMERA",
                ),
              );
            } else {
              return WarningListTile(
                warning: starredList.starreds[index - 2],
              );
            }
          },
          itemCount: starredList.starreds.length + 2,
        ),
      ),
    );
  }
}
