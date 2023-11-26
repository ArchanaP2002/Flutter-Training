void main() {
  //Loops -- for loop
  //       - For each loop
  //       - while loop
  //       - do while loop

  // for loop
  for (int i = 1; i <= 10; i++) {
    print(i);
  }
  for (int i = 10; i >= 1; i--) {
    print(i);
  }
  for (int i = 1; i <= 10; i++) {
    print("Archana");
  }

  // while loop
  int a = 1;
  while (a <= 10) {
    print(a);
    a++;
  }

  int i = 5; // display the even numbers
  while(i<=10){
  if(i%2 == 0){
      print(i);
    }
    i++;
  }

  //do while loop
  int n =10;
  do {
    print( n); // printing 10 to 20
    n++;
  } while (n<=20);

}
