import 'package:flutter/material.dart';
import './appbarButton.dart';

class AppBarConstructor extends StatelessWidget with PreferredSizeWidget {
  final String titleStr;
  final AppBarButton? leftNaviBarButton;
  final AppBarButton? rightNaviBarButton;
  final BuildContext context;

  // Appbar style properties
  final Color appBarBackgroundColor = Colors.white;
  final Color appBarIconColor = Color.fromRGBO(158, 158, 158, 1);
  final double appBarHeight = 100;
  final Color appBarTitleTextColor = Colors.black;
  final double appBarTextFontSize = 60;

  AppBarConstructor({
    required this.titleStr,
    this.leftNaviBarButton,
    this.rightNaviBarButton,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: false,
      title: Text(
        titleStr,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      leading: leftNaviBarButton,
      actions: rightNaviBarButton == null
          ? null
          : [
              rightNaviBarButton!,
            ],
      toolbarHeight: appBarHeight,
      iconTheme: IconThemeData(
        color: appBarIconColor,
      ),
      backgroundColor: appBarBackgroundColor,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
