import 'package:flutter/material.dart';
import 'package:gdsc_client/model/household.dart';
import 'package:gdsc_client/views/homePage.dart';
import 'package:gdsc_client/widgets/appbar/appbar.dart';
import 'package:gdsc_client/widgets/appbar/appbarButton.dart';
import 'package:gdsc_client/widgets/general/householdCard.dart';
import 'package:gdsc_client/widgets/general/tButton.dart';
import 'package:gdsc_client/widgets/general/texttitle.dart';

class HouseholdInfoRegisterPage extends StatefulWidget {
  final List<Household> householdList = [];

  @override
  State<HouseholdInfoRegisterPage> createState() =>
      _HouseholdInfoRegisterPageState();
}

class _HouseholdInfoRegisterPageState extends State<HouseholdInfoRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor(
        titleStr: "Add First Room",
        context: context,
        leftNaviBarButton: AppBarButton(
            buttonCallBack: () => Navigator.of(context).pop(),
            buttonIcon: Icon(Icons.arrow_back),
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
                    titleText: "Household Information",
                    subTitleText:
                        "Please fill in the household information of your first room.",
                  ),
                ],
              );
            } else if (index == widget.householdList.length + 1) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      child: tButton(
                        buttonText: "Done",
                        tButtonPressedCallBack: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      HomePage()),
                              (route) => false);
                        },
                        buttonWidth: 80,
                      ),
                    ),
                  ),
                ],
              );
            }
            return HouseHoldCard();
          },
          itemCount: widget.householdList.length + 2,
        ),
      ),
    );
  }
}
