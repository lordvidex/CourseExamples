import 'package:flutter/material.dart';

import '../constants.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  final bool fromMe;
  MessageBubble(this.sender, this.message, this.fromMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          fromMe ? EdgeInsets.only(right: 10.0) : EdgeInsets.only(left: 10.0),
      
      alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender),
          Container(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.7,
            ),
            margin: EdgeInsets.symmetric(vertical: 4),
            padding: EdgeInsets.all(15),
            child: Text(message),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(fromMe?10:0),
                  topRight: Radius.circular(fromMe?0:10),
                  bottomLeft: Radius.circular(fromMe ? 30 : 10),
                  bottomRight: Radius.circular(fromMe ? 10 : 30),
                ),
                color: fromMe ? Colors.red[100] : Colors.green[100],
                boxShadow: [BoxShadow(offset: Offset(0, 1))]),
          ),
        ],
      ),
    );
  }
}
