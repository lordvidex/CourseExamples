import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../providers/auth.dart';
import './login_screen.dart';
import './chat_screen.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  String _password;

@override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
@override
  void didChangeDependencies() {
    _emailController.text = ModalRoute.of(context).settings.arguments as String;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'hero',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: _emailController,
                  decoration: kTextFieldInputDecoration.copyWith(
                      labelText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //error checks later.. lets dive to firebase
                    _password = value;
                  },
                  obscureText: true,
                  decoration: kTextFieldInputDecoration.copyWith(
                      labelText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    Provider.of<Auth>(context, listen: false)
                        .createNewUserEmailandPassword(
                      email: _emailController.text,
                      password: _password,
                    )
                        .then((_) {
                      _isLoading = false;
                      Navigator.of(context)
                          .pushReplacementNamed(ChatScreen.routeName);
                    }).catchError((e) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('An error occured'),
                          content: Text(e.toString()),
                          actions: <Widget>[
                             FlatButton(
                                  child: Text('Login Instead'),
                                  onPressed: () {
                                    Navigator.of(ctx).popAndPushNamed(LoginScreen.routeName,arguments: _emailController.text);
                                    setState(
                                      () {
                                        _isLoading = false;
                                      },
                                    );
                                  },
                                ),
                            FlatButton(
                                child: Text('Okay'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }),
                          ],
                        ),
                      );
                    });
                  },
                  text: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
