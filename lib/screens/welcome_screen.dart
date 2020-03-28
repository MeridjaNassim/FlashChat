import 'package:flutter/material.dart';
import '../widgets/button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatefulWidget {
  static final String ROUTE_ID = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    
  }
  @override
  void dispose() { 
   
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                    tag: "Logo",
                    child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds : 300),
                  isRepeatingAnimation: false,
                  text :['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ReusableButton(
              onPress: ()=>Navigator.pushNamed(context, LoginScreen.ROUTE_ID),
              color : Colors.lightBlueAccent,
              text : 'Log In'
            ),
            ReusableButton(
              onPress: ()=>Navigator.pushNamed(context, RegistrationScreen.ROUTE_ID),
              color : Colors.blueAccent,
              text : 'Register'
            )
,
          ],
        ),
      ),
    );
  }
}

