import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import './chat_screen.dart';
import './registration_screen.dart';
import '../providers/auth.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  TextEditingController _emailController = TextEditingController();
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
      body: SafeArea(
        child: ModalProgressHUD(
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
                    //TODO: add validations to the app
                    controller: _emailController,
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: 'Enter your email'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      _password = value;
                    },
                    decoration: kTextFieldInputDecoration.copyWith(
                        labelText: 'Enter your password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    text: 'Log In',
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });

                      Provider.of<Auth>(context, listen: false)
                          .loginUserWithEmailandPassword(
                              email: _emailController.text, password: _password)
                          .then(
                        (_) {
                          Navigator.of(context)
                              .pushReplacementNamed(ChatScreen.routeName);
                        },
                      ).catchError(
                        (e) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('An error occured'),
                              content: Text(e.toString()),
                              actions: <Widget>[
                                if(e.toString().contains('not exist'))
                                FlatButton(
                                  child: Text('SignUp Instead'),
                                  onPressed: () {
                                    Navigator.of(ctx).popAndPushNamed(RegistrationScreen.routeName,arguments: _emailController.text);
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
                                    setState(
                                      () {
                                        _isLoading = false;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
