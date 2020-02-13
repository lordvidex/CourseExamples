import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/messages.dart';
import './screens/welcome_screen.dart';
import './screens/login_screen.dart';
import './screens/registration_screen.dart';
import './screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Auth(),
      child: ChangeNotifierProxyProvider<Auth,Messages>(
        update: (_,auth,prevMessage) => Messages(user:auth.user),
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: Provider.of<Auth>(context, listen: false).isLoggedUser(),
      builder: (ctx, snapshot) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: snapshot.connectionState == ConnectionState.waiting
            ? Scaffold(
                body: Center(
                  child: Text('Loading...'),
                ),
              )
            : snapshot.connectionState == ConnectionState.done && snapshot.data
                ? ChatScreen()
                : WelcomeScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
          ChatScreen.routeName: (ctx) => ChatScreen(),
        },
      ),
    );
  }
}
