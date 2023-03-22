import 'package:flutter/material.dart';
import '../widgets/appbar/appbar.dart';
import '../widgets/appbar/appbarButton.dart';
import '../widgets/general/eButton.dart';
import './warningListPage.dart';
import '../model/warning.dart';
import '../mock.dart';

class InspectMainPage extends StatefulWidget {
  @override
  State<InspectMainPage> createState() => _InspectMainPageState();

  List<Warning> warningList = Mock.getWarningList;
}

class _InspectMainPageState extends State<InspectMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor(
        titleStr: "Inspect Mode",
        context: context,
        leftNaviBarButton: AppBarButton(
            buttonCallBack: () => Navigator.of(context).pop(),
            buttonIcon: Icon(Icons.arrow_back),
            context: context),
      ),
      body: Column(
        children: [
          // ARcore
          Container(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: eButton(
                    buttonPressedVoidBack: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return WarningListPage(
                            warningList: widget.warningList,
                          );
                        },
                      ),
                    ),
                    buttonText: "SHOW WARNING LIST",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
