import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String forgetPassword;
  final TextInputType textInputType;
  final bool obscureText;
  final TextEditingController textEditingController;
  MyTextField({
    this.forgetPassword,
    this.obscureText,
    this.textInputType,
    @required this.hintText,
    @required this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: textEditingController,
      keyboardType: textInputType,
      decoration: InputDecoration(
        counter: Text(
          forgetPassword,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
