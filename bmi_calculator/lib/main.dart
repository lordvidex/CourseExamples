import 'package:flutter/material.dart';
import './input_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF101639),
        scaffoldBackgroundColor: Color(0xFF141A3C),
        // textTheme: Theme.of(context).textTheme.copyWith(
        //       body1: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
      ),
      home: InputPage(),
    );
  }
}