int a = 10; //global variable
void main() {
  var name = "archana"; //declaring using var  //local variable
  var age = 21;
  print('name: $name , age: $age');

  age = 22; //Reassigning a variable
  print("Updated Age: $age");

  //explicit declaration
  int number = 30;
  String message = "Hello All!";
  print('num: $number & message: $message');

  // Constant declaration
  const double piValue = 3.14159;
  print('The value of pi is $piValue');

  // Declaring Variables
  double prize = 1130.2232323233233; // valid.
  print(prize.toStringAsFixed(2));

  double amount = 12.344;
  print(amount.round()); //round the given value

  double amount1 = 12.344;
  print(amount1.toStringAsFixed(1));

  //printing multi line
  String multiLine = '''  
  hello,
  hi
  ''';
  print(multiLine);

  num age1 = 23;
  print( age1);

  //next line and tab

  print('hello \n kanini'); // \n for next line
  print('kanini\torganization'); // \t giving space
}
