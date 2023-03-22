import 'package:flutter/material.dart';
import '../widgets/appbar/appbar.dart';
import '../widgets/appbar/appbarButton.dart';
import '../widgets/general/eButton.dart';
import '../model/warning.dart';
import '../widgets/listTile/warningListTile.dart';

class WarningListPage extends StatefulWidget {
  final List<Warning> warningList;

  WarningListPage({
    required this.warningList,
  });

  @override
  State<WarningListPage> createState() => _WarningListPageState();
}

class _WarningListPageState extends State<WarningListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor(
        titleStr: "Warning List",
        context: context,
        leftNaviBarButton: AppBarButton(
            buttonCallBack: () => Navigator.of(context).pop(),
            buttonIcon: Icon(Icons.arrow_back),
            context: context),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            // ARcore
            Expanded(
              child: Container(
                child: widget.warningList.length == 0
                    ? null
                    : ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return WarningListTile(
                            warning: widget.warningList[index],
                          );
                        },
                        itemCount: widget.warningList.length,
                      ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: eButton(
                      buttonPressedVoidBack: () {},
                      buttonText: "SAVE AS STARRED",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
