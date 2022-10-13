import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';
import '../helper/show_snackbar.dart';
import '../screens/chat_screen.dart';

class Auth {
  static Future<void> createUser(BuildContext context, String email, String password) async {
    try{
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      ShowSnackBar.showSnackBar(context, 'Success Registration.', greenColor.withOpacity(0.4));
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(ChatScreen.rn);
    }on FirebaseAuthException catch(ex) {
      if(ex.code == 'weak-password') {
        ShowSnackBar.showSnackBar(context, 'can\'t use a weak password.', Colors.red[300]!);
      } else if (ex.code == 'email-already-in-use') {
        ShowSnackBar.showSnackBar(context, 'can\'t use an existing email.', Colors.red[300]!);
      }
    } catch(ex) {
      ShowSnackBar.showSnackBar(context, 'error exist. please try again later.', Colors.red[300]!);
    }
  }

  static Future<void> loginUser(BuildContext context, String email, String password) async {
    try{
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(ChatScreen.rn);
    }on FirebaseAuthException catch(ex) {
      if(ex.code == 'user-not-found') {
        ShowSnackBar.showSnackBar(context, 'No user found for that email.', Colors.red[300]!);
      } else if (ex.code == 'wrong-password') {
        ShowSnackBar.showSnackBar(context, 'Wrong password for that user.', Colors.red[300]!);
      }
    } catch(ex) {
      ShowSnackBar.showSnackBar(context, 'error exist. please try again later.', Colors.red[300]!);
    }
  }
}