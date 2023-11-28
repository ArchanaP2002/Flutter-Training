// its similar to dictionary

//syntax : Map<Variable type(Key), Variable type(Value)>variable name ={ key:value , key:value};
// key value should be unique
void main(){
  Map <String , String> name = {
    "Name":"Archana", //name -key Archana - value
    "Age":"22",
    "Address":"Tuticorin"
  };
  print(name);
  //Access value from key
  print(name["Name"]);
   /** map properties
   *  .keys
   *  .value
   *  .length
   *  .isEmpty
   *  .isNotEmpty 
   */

  print(name.keys);
  print(name.values);
  print(name.isNotEmpty);

  //Adding elements
  name["location"]="Chennai";
  print(name);
  //updating elements
  name["location"]="Tuticorin";
  print(name);
  //removing
  name.remove("location");
  print(name);
}