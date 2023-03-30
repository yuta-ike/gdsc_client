import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_client/views/goToLoginPage.dart';
import 'package:gdsc_client/views/householdInfoRegisterPage.dart';
import 'package:gdsc_client/views/login.dart';
import 'package:gdsc_client/widgets/appbar/appbar.dart';
import 'package:gdsc_client/widgets/appbar/appbarButton.dart';
import 'package:gdsc_client/widgets/general/inputTextField.dart';
import 'package:gdsc_client/widgets/general/tButton.dart';
import 'package:gdsc_client/widgets/general/texttitle.dart';

class RoomInfoRegisterPage extends StatefulWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  TextEditingController get roomNameController => TextEditingController();
  TextEditingController get roomCityController => TextEditingController();

  @override
  State<RoomInfoRegisterPage> createState() => _RoomInfoRegisterPageState();
}

class _RoomInfoRegisterPageState extends State<RoomInfoRegisterPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      return GoToLoginPage();
    }

    return Scaffold(
      appBar: AppBarConstructor(
        titleStr: "Add first Room",
        context: context,
        leftNaviBarButton: AppBarButton(
          buttonCallBack: () async {
            final navigator = Navigator.of(context);
            await FirebaseAuth.instance.signOut();
            navigator.pushAndRemoveUntil(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LoginPage()),
                (route) => false);
          },
          buttonIcon: Icon(Icons.arrow_back),
          context: context,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                TextTitle(
                  titleText: "Room Information",
                  subTitleText:
                      "Please fill in the information of your first room.",
                ),
                Row(
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
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: tButton(
                      buttonText: "Next",
                      tButtonPressedCallBack: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return HouseholdInfoRegisterPage();
                            },
                          ),
                        );
                      },
                      buttonWidth: 80,
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: 1,
        ),
      ),
    );
  }
}
