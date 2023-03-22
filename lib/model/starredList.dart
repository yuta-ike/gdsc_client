import './warning.dart';

class StarredList {
  final List<Warning> starreds;

  StarredList({
    required this.starreds,
  });

  removeItem(int posi) {
    if (posi < starreds.length) {
      starreds.removeAt(posi);
    }
  }

  addItem(newWarning) {
    starreds.add(newWarning);
  }

  addItems(warningList) {
    starreds.addAll(warningList);
  }
}
