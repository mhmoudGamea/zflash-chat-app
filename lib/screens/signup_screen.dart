import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../authentication/auth.dart';
import '../constants.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  static const rn = '/signup_screen';

  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var isLoading = false;
  String? email;
  String? password;
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(color: formColor),
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
          child: ListView(
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 170,
                  alignment: Alignment.center,
                  child: Image.asset(imagePath, fit: BoxFit.cover, width: 170),
                ),
              ),
              Form(
                key: _form,
                child: Column(
                  children: [
                    CustomTextFormField(
                      onValidate: (value) {
                        if(value!.isEmpty) {
                          return 'Email is required';
                        }else if (!value.contains('@') || !value.contains('com')) {
                          return 'invalid email';
                        }
                        return null;
                      },
                      onChange: (data) {
                        email = data;
                      },
                      text: 'Email',
                      icon: Icons.email,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return 'password is required';
                        }
                        return null;
                      },
                      onChange: (data) {
                        password = data;
                      },
                      text: 'Password',
                      icon: Icons.password,
                      isObscure: true,
                      type: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              CustomButton(
                  text: 'Sign Up',
                  onPress: () async {
                    if (_form.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await Auth.createUser(context, email!, password!);
                        setState(() {
                          isLoading = false;
                        });
                      } catch (error) {
                        setState(() {
                          isLoading = false;
                        });
                        debugPrint('Error while register new user');
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
