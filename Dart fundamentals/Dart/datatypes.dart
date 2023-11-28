//no float and long data types in number

//data types :
/*
1. numbers  - int and double
2. string
3. boolean
4. list
5. map
6. runes
7. sets
8. null
*/

void main() {
  //Numbers
  int n1 = 5;
  double n2 = 6.44;
  print('$n1 and $n2');
  print(n2.floor());
  print(n2.toString());
  print(n2.toStringAsFixed(1));

  // string
  String name = '1';
  print(name.runtimeType);
  print(name.length);
  print(name.runes);
  int name1 = int.parse(name);
  print(name1.runtimeType);

  // boolean
  bool valid = true;
  print(valid);

  //list
  List<String> name2 = ["Archana", "Maha", "priya", "Archana"];
  print(name2);
  print(name2[2]);

  // difference between sets and list is list print duplicate values but set doesn't print duplicate values

  //sets
  // it doesn't print the duplicate value
  Set<String> setName = {
    "Archana",
    "Maha",
    //"Archana"
  }; 
  print(setName);

  //maps
  Map<String, String> details = {'name': 'Archana', 'address': 'Chennai'};
  print(details['name']);

  //runes   -- find asci value or unicode values of string 
  String msg = "Hello All!";
  print(msg.runes);

  print(msg.hashCode);
  print(msg.isEmpty);
  print(msg.isNotEmpty);
}
