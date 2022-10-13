import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import './login_screen.dart';
import './signup_screen.dart';
import '../constants.dart';
import '../custom_widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const rn = '/';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = ColorTween(begin: formColor, end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 65,
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'z Flash Chat',
                        textStyle: const TextStyle(
                            fontFamily: fontName, fontWeight: FontWeight.w900, fontSize: 30),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                  text: 'Log In',
                  onPress: () {
                    Navigator.of(context).pushNamed(LoginScreen.rn);
                  }),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                  text: 'Register',
                  onPress: () {
                    Navigator.of(context).pushNamed(SignupScreen.rn);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
