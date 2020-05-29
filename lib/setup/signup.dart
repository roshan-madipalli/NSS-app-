import 'package:nss/Setup/databaseService.dart';
import 'package:nss/setup/signIn.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  String email;
  String password;
  String username;
  String idno;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Form(
        key: formkey,
        child: Column(children: <Widget>[
          TextFormField(
            validator: (input){
              if(input.isEmpty){
                return 'Please type an email';
              }
            },
            onSaved: (input) => email = input,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            validator: (input){
              if(input.length< 6){
                return 'Your password needs to be atleast 6 characters.';
              }
            },
            onSaved: (input) => password = input,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          TextFormField(
            validator: (input){
              if(input.length> 30){
                return 'Your username should me less than 30 characters';
              }
            },
            onSaved: (input) => username = input,
            decoration: InputDecoration(labelText: 'Username'),
            
          ),
          TextFormField(
            onSaved: (input) => idno = input,
            decoration: InputDecoration(labelText: 'ID'), 
          ),
          RaisedButton(
            onPressed:signUp,
            child: Text('Sign up'),
            ),
        Text('On clicking sign up button a verification email will be sent to your mail account', style: TextStyle(color: Colors.red,fontSize: 10,))
        ],
        )),
    );  
  }

Future<void> signUp() async{
  final formState = formkey.currentState;
  if(formState.validate()){
    formState.save();
    try{
    AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    user.user.sendEmailVerification();
    await DatabaseService(uid:user.user.email).updateUserData(username,idno);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }catch(e){
      print(e.message);
    }
  }
}

}
