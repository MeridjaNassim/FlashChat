import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../widgets/button.dart';
class LoginScreen extends StatefulWidget {
  static final String ROUTE_ID = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool _loggingIn ;
  String _email ;
  String _password ;
 @override
  void initState(){
    super.initState();
    _loggingIn = false ;
  }
  Widget _buildWidget(){
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
                  tag: 'Logo',          
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
                style: Theme.of(context).textTheme.body1,
              decoration: kInputDecorationStyle.copyWith(
                  hintText: "Enter your email"
              )),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
               textAlign: TextAlign.center,
              onChanged: (value) {
               _password = value;
              },
              style: Theme.of(context).textTheme.body1,
              decoration: kInputDecorationStyle.copyWith(
                hintText : 'Enter your password'
              )
            ),
            SizedBox(
              height: 24.0,
            ),  
            
            ReusableButton(
              onPress: ()async{
                try{
                  setState(() {
                    _loggingIn = true ; 
                  });
                  final user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
                   setState(() {
                    _loggingIn = false ; 
                  });
                  if(user != null) {
                     Navigator.pushNamed(context, ChatScreen.ROUTE_ID);
                   }
                }catch(e){
                  print(e);
                  setState(() {
                    _loggingIn = false ;
                  });
                }

              },
              color : Colors.lightBlueAccent,
              text : 'Log In'
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
      body: ModalProgressHUD(inAsyncCall: _loggingIn, child: _buildWidget() )
    );
  }
}
