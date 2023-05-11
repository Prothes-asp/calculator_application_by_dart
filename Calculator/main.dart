import 'package:flutter/material.dart';
import 'package:untitled/home_calculator_screen.dart';

void main(){
  runApp(
    MyApp()
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: calculator_homepage_screen(),
    );
  }
}
