import '../constants.dart';

class Message {
  final String message;
  final String sender;

  Message({required this.message, required this.sender});

  factory Message.fromJson(jsonData) {
    return Message(message: jsonData[messageField], sender: jsonData[senderField]);
  }

}