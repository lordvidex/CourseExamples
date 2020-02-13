import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/messages.dart';
import './login_screen.dart';
import '../components/message_bubble.dart';
import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatController = TextEditingController();
  final _scrollController = ScrollController();
  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  void _sendMessage() {
    if (_chatController.text.isEmpty) {
      return;
    }
    try {
      Provider.of<Messages>(context, listen: false)
          .sendMessage(_chatController.text)
          .then((_) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            curve: Curves.easeOut, duration: Duration(milliseconds: 200));
      });

      _chatController.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userEmail = Provider.of<Messages>(context, listen: false).userEmail;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          LogOutButton(),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Provider.of<Messages>(context, listen: false)
                      .messageStream(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(
                          body: Center(
                              child: Text(
                                  'Error occured: ${snapshot.error}'))); //something
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Scaffold(
                          body: Center(
                            child: Text('Loading...'),
                          ),
                        );
                      default:
                        final List<Widget> _tempList = snapshot.data.documents
                            .map(
                              (doc) => MessageBubble(
                                doc['email'],
                                doc['message'],
                                doc['email'] == _userEmail,
                              ),
                            )
                            .toList();
                        return ListView.builder(
                            controller: _scrollController,
                            itemCount: _tempList.length,
                            itemBuilder: (ctx, index) => _tempList[index]);
                    }
                  }),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        maxLines: 4,
                        minLines: 1,
                        controller: _chatController,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: _sendMessage,
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.close),
        onPressed: () async {
          final action =
              await Provider.of<Auth>(context, listen: false).signOut();
          if (action == null) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('You are not currently logged in!'),
              action: SnackBarAction(
                label: 'Log In',
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName),
              ),
            ));
          }
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        });
  }
}
