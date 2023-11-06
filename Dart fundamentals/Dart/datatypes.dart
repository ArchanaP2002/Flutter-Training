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
  //int name1 = int.parse(name);
  int name1 = int.parse(name);
  print(name1.runtimeType);

 // boolean
  bool istrue = true;
  print(istrue);

 //list
}
