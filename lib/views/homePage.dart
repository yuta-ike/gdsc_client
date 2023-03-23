import 'package:flutter/material.dart';
import 'package:gdsc_clientx/model/user.dart';
import 'package:gdsc_clientx/views/inspectMainPage.dart';
import 'package:gdsc_clientx/widgets/homepage/sideMenu.dart';
import 'package:gdsc_clientx/widgets/listTile/warningListTile.dart';
import 'package:gdsc_clientx/mock.dart';
import 'package:gdsc_clientx/model/starredList.dart';
import 'package:gdsc_clientx/widgets/appbar/appbar.dart';
import 'package:gdsc_clientx/widgets/appbar/appbarButton.dart';
import 'package:gdsc_clientx/widgets/homepage/roomInfoCard.dart';
import 'package:gdsc_clientx/model/room.dart';
import 'package:gdsc_clientx/widgets/general/eButton.dart';
import 'package:gdsc_clientx/views/editRoomPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StarredList starredList = Mock.getMockStarredList;

  final Room room = Mock.getSingleRoom;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = Mock.user;

  final roomListShort = Mock.roomList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarConstructor(
        context: context,
        titleStr: room.roomTitle,
        leftNaviBarButton: AppBarButton(
          buttonCallBack: () {
            _scaffoldKey.currentState!.openDrawer();
          },
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
      drawer: SideMenu(
        currRoom: room,
        roomList: roomListShort,
        user: user,
      ),
      drawerEdgeDragWidth: 0,
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
