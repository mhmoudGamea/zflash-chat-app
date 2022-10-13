import 'package:flutter/material.dart';
import 'package:zflash_app/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  const CustomButton({Key? key, required this.text, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              blueColor,
              greenColor,
            ],
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontFamily: fontName, fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
