import 'dart:io';

// return type as int and the parameter is null
int voter(){
  return 18;
}

String even(){
  int num = 4;
  if (num % 2 ==0) {
    print("The num is even");
    return "The num is even";
  }
  else if(num % 2 !=0){
     print("The num is even");
     return "The num is not even";
  }else{
    return "Not a Number";
  }
  // return 5;
}


void main(){
  print("Enter Your Age:");
  String? ageInput = stdin.readLineSync();
  int age = int.parse(ageInput!);
  if (age >= voter()) {
    print("You are Voter $age");
  } else {
    print("Your not a Voter $age");
  }

  even();
}