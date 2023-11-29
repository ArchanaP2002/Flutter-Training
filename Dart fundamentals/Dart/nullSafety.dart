void main(){
  //Write safe code 
  //easy to find and fix bugs 
  
  //String name = null; // it shows error
  // if we want to declare null 
  String? name = null;
 // name = "Archana";
  print(name);
  if (name==null) {
    print("The name is null");
  } else {
    print("The name is not null");
  }

  //?? assign for a default value
  String name1 = name?? "Sumi";
  print(name1);
  //List
  List<int?>numbers =[1,2,null,4];
  print(numbers);
}