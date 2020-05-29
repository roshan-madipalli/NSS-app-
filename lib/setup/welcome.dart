import './signIn.dart';
import './signup.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to NSS app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          RaisedButton(
            onPressed: navigateToSignIn,
            child: Text('Sign in'),
            color: Colors.green,
            ),
          RaisedButton(
            onPressed: navigateToSignUp,
            child: Text('Sign up'),
            color: Colors.green,
            )
        ],
      ),
    );
  }

void navigateToSignIn(){
 Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
}
void navigateToSignUp(){
 Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true));
}
}