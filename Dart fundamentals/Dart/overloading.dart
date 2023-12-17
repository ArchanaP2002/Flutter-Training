import 'dart:io';

// does not support overloading instead of overloading we use named & optional parameter
class Sample {
  void overloading(String name, [String address = "", location = ""]) {
    // optional parameter it should be []
    print("$name $address $location");
  }

  void overloading2({required int age, required int numbers}) {
    // named parameter
     print("$age $numbers");
  }
}

void main() {
  Sample sample = Sample();
  String? user_input = stdin.readLineSync();
  sample.overloading(user_input!);
  sample.overloading("Archana", "Chennai");
  sample.overloading2(numbers: 15, age: 12);
}
