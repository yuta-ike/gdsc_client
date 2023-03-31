import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_client/model/household.dart';
import 'package:gdsc_client/request.dart';
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
  final Function dataChangedCallback;

  EditRoomPage({
    super.key,
    this.currRoom,
    required this.dataChangedCallback,
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
      _hList =
          widget.currRoom == null ? [] : [...widget.currRoom!.householdList];
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

  _ageOnSaved(String newValue, int index) {
    if (newValue == null || newValue == "") {
      _hList[index].age = 0;
    } else {
      _hList[index].age = int.parse(newValue);
    }
  }

  _heightOnSaved(String newValue, int index) {
    if (newValue == null || newValue == "") {
      _hList[index].height = 0;
    } else {
      _hList[index].height = double.parse(newValue);
    }
  }

  _wheelChairOnSaved(String newValue, int index) {
    _hList[index].needWheelChair = newValue == "No" ? false : true;
  }

  _confirm() async {
    String newRoomName =
        (_roomNameController.text == null || _roomNameController.text == "")
            ? "Room"
            : _roomNameController.text;
    String newRoomCity =
        (_roomCityController.text == null || _roomCityController.text == "")
            ? "City"
            : _roomCityController.text;
    if (widget.currRoom == null) {
      String newRoomId = await Request.postCreateRoom(
        FirebaseAuth.instance.currentUser!.uid,
        newRoomName,
        newRoomCity,
        _hList,
      );
      if (newRoomId != "") {
        if (widget.dataChangedCallback != null) {
          print(newRoomId);

          widget.dataChangedCallback!(newRoomId);
        }
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to create room ")));
      }
    } else {
      bool checker = await Request.postUpdateRoom(
        FirebaseAuth.instance.currentUser!.uid,
        widget.currRoom!.id,
        newRoomName,
        newRoomCity,
        _hList,
      );
      if (checker == true) {
        if (widget.dataChangedCallback != null) {
          widget.dataChangedCallback!(widget.currRoom!.id);
        }
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to edit room Info")));
      }
    }
  }

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
            buttonCallBack: _confirm,
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
                    hintText: "Room",
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
                    hintText: "City",
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
                    heightOnChangedCallback: (newValue) {
                      _heightOnSaved(newValue, index - 3);
                    },
                    ageOnChangedCallback: (newValue) {
                      _ageOnSaved(newValue, index - 3);
                    },
                    wheelChairOnSavedCallback: (newValue) {
                      _wheelChairOnSaved(newValue, index - 3);
                    },
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
