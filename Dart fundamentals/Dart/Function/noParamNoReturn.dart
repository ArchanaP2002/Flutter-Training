
// No Parameter & No Return Type 
// In this (Input()) function No parameter is passed
// If the function have a keyword void at the beginning then its no return type

import 'dart:io';
void Input(){
  print("Name: Archana");
  print("Age: 22");
 
}
void voter(){
  print("Enter Your Age");
  String? ageInput = stdin.readLineSync();
  int age= int.parse(ageInput!);
  if (age >= 18) {
    print("You Are Voter");
  } else {
    print("You Are Not Voter");
  }
}

void main(){
  voter();
   Input();
}