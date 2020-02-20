import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const bottomContainerHeight = 80.0;
const activeCardColor = const Color(0xFF1d1e33);
const inactiveCardColor = const Color(0xFF111328);
const bottomContainerColor = const Color(0xFFfc4d69);

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                ReusableCard(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.mars, size: 80),
                    SizedBox(height: 15),
                    Text('MALE',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF8d8e98)))
                  ],
                ),
                ReusableCard(
                  color: inactiveCardColor,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.venus, size: 80),
                    SizedBox(height: 15),
                    Text('FEMALE',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)))
                  ],
                ),
              ],
            ),
          ),
          ReusableCard(
            children: <Widget>[
              Text('HEIGHT',
                  style: TextStyle(fontSize: 18, color: Color(0xFFFFFFFF))),
            ],
          ),
          Expanded(
            child: Row(
              children: <Widget>[ReusableCard(), ReusableCard()],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            height: bottomContainerHeight,
            color: bottomContainerColor,
          ),
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final Color color;
  final List<Widget> children;
  ReusableCard({this.color = activeCardColor, this.children});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[...?children],
        ),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
