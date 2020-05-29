import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/home.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String email;
  String password;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
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
          RaisedButton(
            onPressed:()=>signIn(context),
            child: Text('Sign in'),
            )

        ],
        )),
    );  
  }

Future<void> signIn(context) async{
  final formState = formkey.currentState;
  if(formState.validate()){
    formState.save();
    try{
    AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    if (user.user.isEmailVerified){
      
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(email:email)));
    
    }
    else{
     verify(context,user);
    }
    }catch(e){
      print(e.message);
    }
  }

}
void verify(BuildContext context,AuthResult user){
  var alertDialog =AlertDialog(
    title: Text('Email not verified'),
    content: Text('Click yes to send the email verification again'),
    actions: <Widget>[
      IconButton(icon: Icon(Icons.check_circle),onPressed: user.user.sendEmailVerification,)
    ],
  );
  showDialog(context: context,
  builder: (BuildContext context)
  {
    return alertDialog;
  });
}

}
