import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/message.dart';

class CustomChatBubble extends StatelessWidget {
  final Message message;
  final bool isItMe;

  const CustomChatBubble({Key? key, required this.message, required this.isItMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isItMe ? Alignment.topRight : Alignment.topLeft,
      child: Column(
        crossAxisAlignment: isItMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: isItMe ? const EdgeInsets.only(top: 7, right: 15) : const EdgeInsets.only(top: 7, left: 15),
            child: Text(
              message.sender,
              style: const TextStyle(
                color: Colors.black54,
                fontFamily: fontName,
                letterSpacing: 0.9,
                fontSize: 13,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: isItMe ? formColor.withOpacity(0.6) : blueColor.withOpacity(0.6),
              borderRadius: BorderRadius.only(
                topLeft: isItMe ? const Radius.circular(15): const Radius.circular(0),
                bottomRight: isItMe ? const Radius.circular(15) : const Radius.circular(0),
                bottomLeft: isItMe ? const Radius.circular(0) : const Radius.circular(15),
                topRight: isItMe ? const Radius.circular(0) : const Radius.circular(15),
              ),
            ),
            child: Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: fontName,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
