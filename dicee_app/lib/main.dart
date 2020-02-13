import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftRand = 1;
  int rightRand = 1;
  void generate() {
    setState(() {
      leftRand = Random().nextInt(6) + 1;
      rightRand = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
                child: Image.asset('assets/images/dice$leftRand.png'),
                onPressed: () => generate()),
          ),
          Expanded(
            child: FlatButton(
                child: Image.asset('assets/images/dice$rightRand.png'),
                onPressed: () => generate()),
          ),
        ],
      ),
    );
  }
}
