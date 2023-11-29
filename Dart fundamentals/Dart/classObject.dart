import 'dart:io';

class Circle{
  //pi*r*r -- formula
  double? pi = null; // Properties
  double? r = null;
 // function of area
 void area(){
  pi = 3.14;
  print("Enter the value");
  String? area_circle = stdin.readLineSync();
  double r = double.parse(area_circle!);
  double total = pi!*r*r;
  print(total);
 }
}
void main(){
  //object of circle 
  Circle circle =Circle();
  //function of circle called
  circle.area();
}