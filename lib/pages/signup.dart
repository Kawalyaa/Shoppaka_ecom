import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/componants/round_button.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const String id = 'signup';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    UserProv authProvider = Provider.of<UserProv>(context);
    return Scaffold(
      key: authProvider.key2,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Shopla',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Form(
              key: authProvider.formKey2,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: authProvider.name,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Ful name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ('Name Field Is Required');
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: authProvider.email,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter email',
                    ),
                    validator: (value) {
                      if (value.isNotEmpty) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);
                        if (!regExp.hasMatch(value))
                          return ('The email is invalid');
                      } else {
                        return ('Please provide email');
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: authProvider.password,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    textAlign: TextAlign.center,
                    obscureText: _toggleVisibility,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              _toggleVisibility = !_toggleVisibility;
                            },
                          );
                        },
                        icon: _toggleVisibility
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password Field Is Required';
                      } else if (value.length < 6)
                        return 'Password must be atleast 6 characters';
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedButton(
                buttonText: 'Sign up',
                onPressed: () async {
                  //await Firebase.initializeApp();
                  if (authProvider.formKey2.currentState.validate()) {
                    showProgress(context, 'Creating new account...', false);
                    if (!await authProvider.signUp()) {
                      hideProgress();

                      showAlertDialog(context, "Error", "SignUp Failed");

                      return;
                    } else {
                      hideProgress();
                      authProvider.clearController();
                      authProvider.reloadUser();
                      Navigator.pushReplacementNamed(context, HomePage.id);
                    }
                  } //validateForm();
                })
          ],
        ),
      ),
    );
  }
}
