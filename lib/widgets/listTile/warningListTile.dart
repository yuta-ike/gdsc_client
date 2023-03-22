import 'package:flutter/material.dart';
import '../../model/warning.dart';
import '../../views/editWarningPage.dart';

class WarningListTile extends StatelessWidget {
  final Warning warning;

  WarningListTile({
    required this.warning,
    // required this.editButtonPressedCallBack,
  });

  final Container warningIcon = Container(
    child: Icon(Icons.warning),
    padding: EdgeInsets.all(10),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Card(
        child: ListTile(
          leading: warningIcon,
          title: Text(warning.warningTitle),
          subtitle: Text(warning.warningIntroText),
          trailing: IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return EditWarningPage(
                    warning: warning,
                  );
                },
              ),
            ),
            icon: Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
