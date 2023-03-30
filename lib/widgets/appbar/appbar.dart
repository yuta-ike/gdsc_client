import 'package:flutter/material.dart';
import './appbarButton.dart';

class AppBarConstructor extends StatefulWidget with PreferredSizeWidget {
  final String titleStr;
  final AppBarButton? leftNaviBarButton;
  final AppBarButton? rightNaviBarButton;
  final BuildContext context;

  AppBarConstructor({
    required this.titleStr,
    this.leftNaviBarButton,
    this.rightNaviBarButton,
    required this.context,
  });

  @override
  State<AppBarConstructor> createState() => _AppBarConstructorState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(60.0);
}

class _AppBarConstructorState extends State<AppBarConstructor> {
  // Appbar style properties
  final Color appBarBackgroundColor = Colors.white;

  final Color appBarIconColor = Color.fromRGBO(158, 158, 158, 1);

  final double appBarHeight = 100;

  final Color appBarTitleTextColor = Colors.black;

  final double appBarTextFontSize = 60;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: false,
      title: Text(
        widget.titleStr,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      leading: widget.leftNaviBarButton,
      actions: widget.rightNaviBarButton == null
          ? null
          : [
              widget.rightNaviBarButton!,
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
