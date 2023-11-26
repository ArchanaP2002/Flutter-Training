void main() {
  //break
  int day = 2;
  switch (day) {
    case 1:
      print("The day is Sunday");
      break;
    case 2:
      print("The day is Monday");
      break;
    case 3:
      print("The day is Tuesday");
      break;
    default:
      print("Invalid day");
      break;
  }

  for (var i = 1; i < 5; i++) {
    if (i == 2) {
      break;
    }
    print(i);
  }
  // continue
  for (var i = 1; i < 5; i++) {
    if (i == 2) {
      continue;
    }
    print(i);
  }
}
