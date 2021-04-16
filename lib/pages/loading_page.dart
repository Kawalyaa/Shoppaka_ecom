import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  static const String id = "loadingPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'LOADING.....',
            style: TextStyle(
                color: kColorRed, fontWeight: FontWeight.w900, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
