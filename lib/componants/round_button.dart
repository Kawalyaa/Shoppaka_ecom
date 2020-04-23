import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  RoundedButton({this.buttonText, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.2,
      color: Color(0xFFFF0025),
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        minWidth: 200.0,
        height: 35.0,
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16.0,
            color: Color(0xFFFED0E5),
          ),
        ),
      ),
    );
  }
}
