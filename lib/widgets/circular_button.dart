import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color boderColor;
  final Color textColor;
  final Function whenPress;
  CircularButton({@required this.title,@required this.buttonColor,@required this.boderColor,@required this.textColor,@required this.whenPress});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 300,
      child: RaisedButton(
        onPressed:whenPress,
        elevation: 2,
        shape: RoundedRectangleBorder(
           side: BorderSide(color: boderColor, width: 2),
          borderRadius: BorderRadius.circular(30),
          
        ),
        
        color: buttonColor,
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
