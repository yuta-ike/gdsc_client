import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/general/eButton.dart';
import '../widgets/appbar/appbar.dart';
import '../widgets/appbar/appbarButton.dart';
import '../widgets/general/texttitle.dart';
import '../widgets/general/inputTextField.dart';
import '../model/warning.dart';

class EditWarningPage extends StatefulWidget {
  final Warning warning;

  EditWarningPage({
    required this.warning,
  });

  TextEditingController get _titleEditingController =>
      TextEditingController(text: warning.warningTitle);

  TextEditingController get _introductionController =>
      TextEditingController(text: warning.warningIntroText);

  Function _textEditingValidator = (value) {
    if (value == null || value == "") {
      return "Please input text.";
    }
    return null;
  };

  @override
  State<EditWarningPage> createState() => _EditWarningPageState();
}

class _EditWarningPageState extends State<EditWarningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarConstructor(
        titleStr: "Edit Warning",
        context: context,
        leftNaviBarButton: AppBarButton(
          buttonCallBack: () => Navigator.of(context).pop(),
          buttonIcon: Icon(Icons.arrow_back),
          context: context,
        ),
        rightNaviBarButton: AppBarButton(
          buttonCallBack: () {},
          buttonIcon: Icon(Icons.check),
          context: context,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: InputTextField(
                      label: "Title",
                      textInputController: widget._titleEditingController,
                      validator: widget._textEditingValidator,
                      fieldLength: 250,
                      hintText: "title",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: InputTextField(
                      label: "Introduction",
                      textInputController: widget._introductionController,
                      validator: widget._textEditingValidator,
                      fieldLength: 250,
                      hintText: "introduction",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextTitle(
                    titleText: "Screenshot",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: widget.warning.screenShotBase64 == null
                        ? null
                        : Image.memory(
                            base64Decode(widget.warning.screenShotBase64!),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: eButton(
                        buttonPressedVoidBack: () {},
                        buttonText: "DELETE WARNING"),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              );
            }
            return null;
          },
          itemCount: 1,
        ),
      ),
    );
  }
}
