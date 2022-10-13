import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../custom_widgets/custom_chat_bubble.dart';
import '../models/message.dart';

class ChatScreen extends StatefulWidget {
  static const rn = '/chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messages = FirebaseFirestore.instance.collection(collectionName);
  final _auth = FirebaseAuth.instance;
  late User signedUserInfo;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    getUserInformation();
    super.initState();
  }

  // function to get Uid + email of the user
  void getUserInformation() async {
    try {
      final user = _auth.currentUser; // [currentUser] getter that return User
      if (user != null) {
        signedUserInfo = user;
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  // function to add collection and store messages + sender emails to it
  void submitData(String email, String messageBody) {
    messages.add({senderField: email, messageField: messageBody, dateField: DateTime.now()});
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: formColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 50,
              fit: BoxFit.cover,
            ),
            const Text(
              'zFlash',
              style: TextStyle(fontFamily: fontName),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(dateField, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: formColor,
            ));
          } else {
            List<Message> myMessages = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              myMessages.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: myMessages.length,
                    itemBuilder: (context, index) => CustomChatBubble(
                        message: myMessages[index],
                        isItMe: signedUserInfo.email == myMessages[index].sender),
                  ),
                ),
                // you should wrap this row with container
                Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 6)
                    ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 20, bottom: 6),
                            constraints: const BoxConstraints(maxHeight: 40),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: _textFieldController,
                              decoration: const InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              submitData(signedUserInfo.email!, _textFieldController.text);
                            },
                            icon: Icon(
                              Icons.send,
                              size: 20,
                              color: formColor.withOpacity(0.6),
                            ))
                      ],
                    )),
              ],
            );
          }
        },
      ),
    );
  }
}