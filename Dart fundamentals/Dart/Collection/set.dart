void main(){
  // list allow duplicate item 
  // doesn't allow duplicate item it should be unique item

  // Syntax: Set <Variable type> variable name = {item};

  Set<String> Fruits ={"Apple","Mango","Orange"};
  print(Fruits);

  //check the available values
  print(Fruits.contains("Apple")); // case sensitive

  //add & remove item
  Fruits.add("Grapes");
  Fruits.remove("Apple");
  print(Fruits);
  Fruits.addAll({"Apple","PineApple","Avocado"});
  print(Fruits);

  //find the index value 
  print(Fruits.elementAt(2));
}