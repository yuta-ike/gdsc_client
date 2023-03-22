class Household {
  int age;
  double height;
  bool needWheelChair;

  Household({
    required this.age,
    required this.height,
    required this.needWheelChair,
  });

  editHouseHoldInfo(newAge, newHeight, newStatusOfWheelChair) {
    age = newAge;
    height = newHeight;
    needWheelChair = newStatusOfWheelChair;
  }
}
