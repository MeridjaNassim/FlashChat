import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class RegistrationScreen extends StatefulWidget {
  static final String ROUTE_ID = 'register_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth =FirebaseAuth.instance;
  bool _registering ;
  String _email ;
  String _password ;

  @override
  void initState(){
    super.initState();
    _registering = false ;
  }

  Widget _buildWidget() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          margin: EdgeInsets.only(top : 60),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
                  child: Hero(
                  tag : 'Logo',
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
              textAlign: TextAlign.center,
              onChanged: (value) {
                _email = value ;
              },
              decoration: kInputDecorationStyle.copyWith(
                hintText : 'Enter your email'
              )
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
               textAlign: TextAlign.center,
              onChanged: (value) {
               _password = value;
              },
              decoration: kInputDecorationStyle.copyWith(
                hintText : 'Enter your password'
              )
            ),
            SizedBox(
              height: 24.0,
            ),
             ReusableButton(
              onPress: () async{
                // print('email == $email');
                // print('password == $password');
                try {
                  setState(() {
                    _registering = true ;
                  });
                   final newUser = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
                  setState(() {
                    _registering = false ;
                  });
                   if(newUser != null) {
                     Navigator.pushNamed(context, ChatScreen.ROUTE_ID);
                   }
                }catch(e) {
                  print(e);
                }
              

              },
              color : Colors.blueAccent,
              text : 'Register'
            ),
          ],
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(inAsyncCall: _registering, child: _buildWidget())
    );
  }
}
