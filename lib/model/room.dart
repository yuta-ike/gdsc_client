import './household.dart';

class Room {
  String roomTitle;
  String roomCity;
  final String id;
  final List<Household> householdList;

  bool get needWheelChair =>
      householdList
          .where(
            (element) => element.needWheelChair,
          )
          .toList()
          .length >
      0;

  Room({
    required this.roomTitle,
    required this.roomCity,
    required this.id,
    required this.householdList,
  });

  editRoomInfo(newTitle, newCity) {
    roomTitle = newTitle;
    roomCity = newCity;
  }

  addHousehold() {}

  removeHousehold() {
    if (!householdList.isEmpty) {
      householdList.removeLast();
    }
  }
}
