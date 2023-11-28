// syntax: List <variable type> =[value];
// eg:
/*
Int:
List<int> number =[1, 2,3];
String:
 List<String> text = ["Green","Red","Blue"];
Mixed:
 var mixed = [10,"Red",16];
 */

/**
 * List Properties
 *  .first
 *  .last
 * .length
 * .isEmpty
 * .isNotEmpty
 * .reversed
 * .single
 */
/**
 * Types:  Fixed Length List
 *         Growable List[Most Used]
 */

//Fixed Length List

void fixed() {
  List<int> numbers =
      List.filled(5, 0); // we can't change the size but we can change the value
  var number = List<String>.filled(5, "Hi");
  print(numbers);
  number[0] = "Hello";
  print(number);
}

void Growable() {
  //we can change the list size and value
  List<int> age = [22, 43, 12];
  print(age);
  age.add(34);
  print(age);
}

void main() {
  fixed();
  Growable();
  //Get Index by Value
  List<int> n = [12, 45, 46, 23];
  print(n.indexOf(45));
  print(n.indexed);
  print(n[0]);
  //mutable & Immutable list
  //mutable
  List<int> n1 = [12, 45, 46, 23];
  n1.add(33); //add a value
  print(n1);
  //Immutable list
  const List<String> text= ["Hello","Hi"]; 
  // text.add("h2"); // impossible
  print(text);

  //List Properties

  print(text.first);
  print(text.last);
  print(text.reversed);
  print(text.length);
  print(text.isEmpty);
  print(text.isNotEmpty);
  //print(text.single); // is the list element contains only one value it is true otherwise it shows unhandled exception error
}
