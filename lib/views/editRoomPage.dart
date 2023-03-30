import 'package:flutter/material.dart';
import 'package:gdsc_client/model/household.dart';
import 'package:gdsc_client/views/roomInfoRegisterPage.dart';
import 'package:gdsc_client/widgets/general/householdCardButtons.dart';
import '../widgets/appbar/appbar.dart';
import '../widgets/appbar/appbarButton.dart';
import '../model/room.dart';
import '../widgets/general/texttitle.dart';
import '../widgets/general/inputTextField.dart';
import '../widgets/general/householdCard.dart';
import '../widgets/general/eButton.dart';

class EditRoomPage extends StatefulWidget {
  final Room? currRoom;

  EditRoomPage({
    this.currRoom,
  });

  @override
  State<EditRoomPage> createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  List<Household> _hList = [];
  TextEditingController _roomNameController = TextEditingController();
  TextEditingController _roomCityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _hList = widget.currRoom == null ? [] : widget.currRoom!.householdList;
      if (widget.currRoom != null) {
        _roomNameController.text = widget.currRoom!.roomTitle;
        _roomCityController.text = widget.currRoom!.roomCity;
      }
    });
  }

  _addHousehold() {
    setState(() {
      _hList.add(Household(
        age: 0,
        height: 0,
        needWheelChair: false,
      ));
    });
  }

  _removeHousehold() {
    setState(() {
      if (_hList.length > 0) {
        _hList.removeLast();
      }
    });
  }

  _confirmEditRoom() {}

  _deleteRoom() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor(
        titleStr: widget.currRoom == null ? "Add Room" : "Edit Room Info",
        context: context,
        leftNaviBarButton: AppBarButton(
          buttonCallBack: () => Navigator.of(context).pop(),
          buttonIcon: Icon(
            Icons.arrow_back,
          ),
          context: context,
        ),
        rightNaviBarButton: AppBarButton(
            buttonCallBack: _confirmEditRoom,
            buttonIcon: Icon(Icons.check),
            context: context),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextTitle(
                    titleText: "Basic Info",
                  ),
                ],
              );
            } else if (index == 1) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InputTextField(
                    validator: (value) {
                      if (value == null) {
                        return "Please enter room name.";
                      }
                      return null;
                    },
                    label: "Room Name",
                    textInputController: _roomNameController,
                    fieldLength: 160,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InputTextField(
                    validator: (value) {
                      if (value == null) {
                        return "Please enter city.";
                      }
                      return null;
                    },
                    label: "City",
                    textInputController: _roomCityController,
                    fieldLength: 100,
                  ),
                ],
              );
            } else if (index == 2) {
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextTitle(
                        titleText: "Household Info",
                      ),
                      HouseholdCardButtons(
                        addHouseholdCallBack: _addHousehold,
                        removeHouseholdCallBack: _removeHousehold,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else if (index == _hList.length + 3) {
              return widget.currRoom == null
                  ? null
                  : Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: eButton(
                              buttonPressedVoidBack: _deleteRoom,
                              buttonText: "DELETE ROOM"),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    );
            } else {
              return Column(
                children: [
                  HouseHoldCard(
                    household: _hList[index - 3],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              );
            }
          },
          itemCount: _hList.length + 4,
        ),
      ),
    );
  }
}
