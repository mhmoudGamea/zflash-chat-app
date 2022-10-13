import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextFormField extends StatelessWidget {
  String? Function(String?) onValidate;
  final Function(String?) onChange;
  final String text;
  final IconData icon;
  TextInputType? type;
  late bool isObscure;

   CustomTextFormField({Key? key,required this.onValidate, required this.onChange, required this.text, required this.icon, this.isObscure = false, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: formColor, errorColor: Colors.red),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: formColor, width: 1.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          validator: onValidate,
          onChanged: onChange,
          keyboardType: type ??= TextInputType.none,
          obscureText: isObscure,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(icon),
            hintText: text,
            hintStyle: const TextStyle(fontFamily: fontName, letterSpacing: 1.1),
            contentPadding: const EdgeInsets.only(left: 10, top: 10),
          ),
        ),
      ),
    );
  }
}
