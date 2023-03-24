import 'package:flutter/material.dart';
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

  TextEditingController get roomNameController =>
      TextEditingController(text: currRoom == null ? "" : currRoom!.roomTitle);
  TextEditingController get roomCityController =>
      TextEditingController(text: currRoom == null ? "" : currRoom!.roomCity);

  @override
  State<EditRoomPage> createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor(
        titleStr: "Edit Room Info",
        context: context,
        leftNaviBarButton: AppBarButton(
          buttonCallBack: () => Navigator.of(context).pop(),
          buttonIcon: Icon(
            Icons.arrow_back,
          ),
          context: context,
        ),
        rightNaviBarButton: AppBarButton(
            buttonCallBack: () {},
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
                    textInputController: widget.roomNameController,
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
                    textInputController: widget.roomCityController,
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
                  TextTitle(
                    titleText: "Household Info",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else if (index ==
                (widget.currRoom == null
                        ? 0
                        : widget.currRoom!.householdList.length) +
                    3) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: eButton(
                        buttonPressedVoidBack: () {},
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
                    household: widget.currRoom!.householdList[index - 3],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              );
            }
          },
          itemCount: (widget.currRoom == null
                  ? 0
                  : widget.currRoom!.householdList.length) +
              4,
        ),
      ),
    );
  }
}
