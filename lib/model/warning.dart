import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Warning {
  // priority
  String warningTitle;
  String warningIntroText;
  String priority;
  final Image screenShot;
  final String id;
  final String? screenShotBase64;

  Warning({
    required this.warningTitle,
    required this.warningIntroText,
    required this.screenShot,
    required this.id,
    required this.priority,
    this.screenShotBase64,
  });

  String get warningTitleShort => warningTitle;
  String get warningIntroShort => warningIntroText;

  editWarningInfo(newTitle, newIntroText) {
    warningTitle = newTitle;
    warningIntroText = newIntroText;
  }

  send() {}
}
