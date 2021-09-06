import 'package:ecommerce_app/componants/round_button.dart';
import 'package:ecommerce_app/pages/reset_password_page.dart';
import 'package:ecommerce_app/pages/second_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ResetPasswordReady extends StatelessWidget {
  static const String id = 'resetPasswordReady';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 40, 15.0, 5.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text('Email has been sent!',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  top: 10.0,
                ),
                child: Text(
                  'Please check your inbox and click in the received link to reset password',
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red[50]),
                  child: Image.asset(
                    'images/logos/shopla6.png',
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 80.0,
              ),
              RoundedButton(
                  buttonText: 'Login',
                  onPressed: () {
                    Navigator.pushNamed(context, SecondLogin.id);
                  }),
              SizedBox(
                height: 20.0,
              ),
              RichText(
                  text: TextSpan(
                text: 'Didn\'t receive the link?',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, ResetPassword.id);
                      },
                    text: ' Resend',
                    style: TextStyle(
                        color: kColorRed, fontWeight: FontWeight.bold),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
