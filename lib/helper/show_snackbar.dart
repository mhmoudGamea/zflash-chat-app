import 'package:flutter/material.dart';
import '../constants.dart';

class ShowSnackBar {
  static showSnackBar(BuildContext context, Object message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 5),
        content: Text(
          message.toString(),
          style: const TextStyle(fontFamily: fontName, letterSpacing: 1.1, color: Colors.white, fontSize: 15),
        )));
  }
}