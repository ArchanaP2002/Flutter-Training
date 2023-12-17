 import 'package:flutter/material.dart';

 void main(){
  runApp(const MyApp());
 }

 class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 // String placeholder="";
  int i =0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // for the debug banner its boolean 
     // highContrastTheme: ThemeData.dark(),
      home: Scaffold(
        body: Center(child: Text("How Many Times You Clicked $i")),
        appBar: AppBar(
        title: const Text("Hello World"),
        centerTitle: true, // boolean 
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: (){
          setState(() {
                     // placeholder: "Clicked";
                     i= i+2;

          });
   
      }),
       ),
    );
  }
}

 