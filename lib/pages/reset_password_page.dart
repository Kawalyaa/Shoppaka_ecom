import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/componants/round_button.dart';
import 'package:ecommerce_app/pages/reset_password_ready.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ResetPassword extends StatelessWidget {
  static const String id = 'resetPassword';

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    final _auth = FirebaseAuth.instance;
    final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text('Forgot Your Password?',
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
                    'Enter your registered Email below to receive password reset instructions',
                    style: TextStyle(color: Colors.black54, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red[50]),
                        child: Image.asset(
                          'images/logos/shopla6.png',
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
                SizedBox(
                  height: 80.0,
                ),
                TextFormField(
                  controller: _email,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter email',
                  ),
                  validator: (value) => EmailValidator.validate(value.trim())
                      ? null
                      : "Valid Email is required",
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedButton(
                    buttonText: 'SEND',
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // TODO Check if email is from Shopla users list
                        _auth
                            .sendPasswordResetEmail(email: _email.text)
                            .whenComplete(
                              () => Navigator.pushNamed(
                                  context, ResetPasswordReady.id),
                            );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
