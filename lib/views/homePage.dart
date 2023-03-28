import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_client/views/goToLoginPage.dart';
import '../views/inspectMainPage.dart';
import '../widgets/homepage/sideMenu.dart';
import '../widgets/listTile/warningListTile.dart';
import '../mock.dart';
import '../model/starredList.dart';
import '../widgets/appbar/appbar.dart';
import '../widgets/appbar/appbarButton.dart';
import '../widgets/homepage/roomInfoCard.dart';
import '../model/room.dart';
import '../widgets/general/eButton.dart';
import '../views/editRoomPage.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StarredList starredList = Mock.getMockStarredList;

  final roomListShort = Mock.roomList;
  final Room room = Mock.getSingleRoom;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return GoToLoginPage();
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarConstructor(
        context: context,
        titleStr: room.roomTitle,
        leftNaviBarButton: AppBarButton(
          buttonCallBack: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          buttonIcon: const Icon(Icons.menu),
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
          buttonIcon: const Icon(Icons.edit),
          context: context,
        ),
      ),
      drawer: SideMenu(
        currRoom: room,
        roomList: roomListShort,
        user: widget.user!,
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
