void main(){
  // List in Dart 

  List<int> number = [1,2,3];
  print(number);
  print(number.length);
  number.add(8);
  print(number);
  number.addAll([4,6,5]);
  print(number);
  print( number.reversed);
  print(number.indexOf(4));
  number.remove(3); // remove the element by value or index
  print(number);
  print(number.contains(3)); // checks the list contains specific element
}