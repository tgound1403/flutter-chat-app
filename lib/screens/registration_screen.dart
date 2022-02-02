import 'package:flash_chat/screens/constant.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  bool showSpinner = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Input the email', focusColor: Colors.blueAccent),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Input the password',
                    focusColor: Colors.blueAccent),
                obscureText: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(Colors.blueAccent, 'Register', () async  {
                setState(() {
                  showSpinner = true;
                });
                try {
                final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                if (newUser != null)
                  Navigator.pushNamed(context, ChatScreen.id);
                setState(() {
                  showSpinner = false;
                });
                }
                    catch (e) {
                  print(e);
                  setState(() {
                    showSpinner = false;
                  });
                    }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
