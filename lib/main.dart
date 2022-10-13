import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';

import './screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/chat_screen.dart';
import './constants.dart';

void main() async{
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'zFlash',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(primary: formColor, error: Colors.red),
      ),
      initialRoute: WelcomeScreen.rn,
      routes: {
        WelcomeScreen.rn: (context) => const WelcomeScreen(),
        LoginScreen.rn: (context) => const LoginScreen(),
        SignupScreen.rn: (context) => SignupScreen(),
        ChatScreen.rn: (context) => const ChatScreen(),
      },
    );
  }
}
