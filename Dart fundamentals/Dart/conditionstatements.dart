import 'dart:io';

void main(){ 
  // // Getting Input from the user 
  // print("Enter Your Name");
  // //Read the user input 
  // String? userInput = stdin.readLineSync();
  // print(userInput);

  //Condition --  types - if condition
  //                    - if else condition
  //                    - if else if condition
  //                    - switch case 

  //if condition
  int num = 2;
  if(num<3){
    print("The given number $num is less than 3");
  }

  //if else condition
  print( "Enter Your Age");
  String? ageInput = stdin.readLineSync();
  int age = int.parse(ageInput!);
  if(age <= 18){
    print("the Age is not eligible for vote");
  }
  else{
    print("the Age is eligible for vote");
  }

  //if else if condition
  int month = 2;
  if(month == 1){
    print("The month is jan");
  }
  else if(month==2){
    print("The month is feb");
  }
  else if(month==3){
  print("The month is march");
  }
  else{
    print("The month is May");
  }

  //Switch case
  int day =3;
  switch (day){
    case 1 :
    print("Day is sunday");
    case 2 :
    print("Day is monday");
    case 3 :
    print("Day is tuesday");
    case 4 :
    print("Day is wednesday");
  }

}