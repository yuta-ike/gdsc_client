import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_client/model/roomShort.dart';
import 'package:gdsc_client/request.dart';
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
  HomePage({
    super.key,
  });
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RoomShort>? _roomListShort = [];
  String _currRoomId = "1";
  final StarredList starredList = Mock.getMockStarredList;

  Room _room = Room(roomTitle: "", roomCity: "", id: "", householdList: []);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _updateRoomShortList(bool isInit) async {
    List<RoomShort>? rListShort = await Request.getUserInfo(widget.user!.uid);
    if (isInit == true) {
      _currRoomId = rListShort![0].id;
    }
    Request.getUserInfo(widget.user!.uid).then((value) {
      setState(() {
        _roomListShort = rListShort!;
      });
    });
  }

  _updateCurrRoom(String roomId) async {
    Request.getRoomInfo(widget.user!.uid, roomId).then((value) {
      setState(() {
        _room = value!;
      });
    });
  }

  _refreshDataAfterEditRoom(String roomId) {
    _currRoomId = roomId;
    _updateCurrRoom(roomId);
    _updateRoomShortList(false);
  }

  _sideMenuItemOnTapCallback(String roomId) {
    _currRoomId = roomId;
    Request.getRoomInfo(widget.user!.uid, roomId).then((value) {
      setState(() {
        _room = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _updateRoomShortList(true);
    _updateCurrRoom(_currRoomId);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return GoToLoginPage();
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarConstructor(
        context: context,
        titleStr: _room.roomTitle,
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
                  dataChangedCallback: _refreshDataAfterEditRoom,
                  currRoom: _room,
                );
              },
            ),
          ),
          buttonIcon: const Icon(Icons.edit),
          context: context,
        ),
      ),
      drawer: SideMenu(
        roomCreateCallback: _refreshDataAfterEditRoom,
        currRoomId: _currRoomId,
        roomList: _roomListShort!,
        user: widget.user!,
        listTileOnTapCallback: _sideMenuItemOnTapCallback,
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
                room: _room,
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
