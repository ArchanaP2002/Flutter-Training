class text{
  //Declaring a property
  late String title;
  //Getter 
  String get getName{
    return title;
  }
  //Setter
  set setName(String name){
    title = name;
  }

}
void main(){
  //Creating instance of class
  text tex =text();
   // Calling the set_name method(setter method we created)
  // To set the value in Property "Archana"
  tex.setName = "Archana";
   // Calling the get_name method(getter method we created)
  // To get the value from Property "getName"
  print("My Name is ${tex.getName}");
 
}