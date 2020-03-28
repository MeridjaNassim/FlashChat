import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:flutter/services.dart';

void main(){
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
      runApp(FlashChat());
    });
  
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      initialRoute: WelcomeScreen.ROUTE_ID,
      routes : {
        WelcomeScreen.ROUTE_ID : (context) => WelcomeScreen(),
        LoginScreen.ROUTE_ID: (context)=> LoginScreen(),
        RegistrationScreen.ROUTE_ID: (context)=> RegistrationScreen(),
        ChatScreen.ROUTE_ID : (context)=> ChatScreen()
      }
    );
  }
}
