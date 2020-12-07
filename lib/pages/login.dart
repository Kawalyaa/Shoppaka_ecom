import 'package:ecommerce_app/componants/alart_dialogue.dart';
import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/componants/screen_controller.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/signup.dart';
import 'package:ecommerce_app/provider/app_state_provider.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/componants/round_button.dart';
import 'package:flutter/services.dart';
import '../db/users.dart';
import '../provider/user_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final _key = GlobalKey<ScaffoldState>();

  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProv>(context);

    return Scaffold(
      key: authProvider.key,
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
                  fontWeight: FontWeight.w900,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 50.0,
            ),
            Form(
              key: authProvider.formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
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
                        return ('Email field should not be empty');
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: _toggleVisibility,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    controller: authProvider.password,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _toggleVisibility = !_toggleVisibility;
                          });
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
              height: 15.0,
            ),
            RoundedButton(
                buttonText: 'LOGIN',
                onPressed: () async {
                  //await Firebase.initializeApp();
                  if (authProvider.formKey.currentState.validate()) {
                    showProgress(context, 'Logging in, please wait...', false);
                    if (!await authProvider.signIn()) {
                      hideProgress();
                      showAlertDialog(context, "Error", "Login Failed");
                      return;
                    } else {
                      hideProgress();
                      authProvider.clearController();
                      authProvider.reloadUser();
                      Navigator.pushReplacementNamed(context, HomePage.id);
                    }

                    //validateForm();
                  }
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'or',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SignUp.id);
                    },
                    child: Text(
                      'Register',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//if (authProvider.formKey.currentState.validate()) {
//if (!await authProvider.signIn()) {
//_key.currentState.showSnackBar(
//SnackBar(
//content: Text('Login Failed'),
//),
//);
//return;
//} else {
//authProvider.clearController();
//Navigator.pushReplacementNamed(
//context, HomePage.id);
//}
