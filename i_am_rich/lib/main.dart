import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I am rich',
      home: Scaffold(
        appBar: AppBar(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              image: NetworkImage(
                  'https://www.remove.bg/assets/start_remove-79a4598a05a77ca999df1dcb434160994b6fde2c3e9101984fb1be0f16d0a74e.png'),
            ),
          ),
          backgroundColor: Colors.blueGrey[900],
          title: Text(
            'I am Rich',
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Image(
            image: AssetImage('assets/images/diamond.png'),
          ),
        ),
      ),
    );
  }
}
