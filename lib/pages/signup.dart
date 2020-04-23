import 'package:ecommerce_app/componants/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/componants/round_button.dart';
import 'package:flutter/services.dart';
import '../db/users.dart';
import 'home_page.dart';
import '../provider/user_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const String id = 'signup';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserUpdateInfo userUpdatedInfo = UserUpdateInfo();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _toggleVisibility = true;
  UserServices _userServices = UserServices();

  void validateForm() async {
    FormState formState = _formKey.currentState;

    if (formState.validate()) {
      final FirebaseUser _currentUser = await _auth.currentUser();

      if (_currentUser == null) {
        try {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          _userServices.createUserWithEmailAndPassword(
              _name.text, _email.text, _password.text);

          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return user.status == Status.AUTHENTICATING
        ? Loading()
        : Scaffold(
            key: _key,
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
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: _name,
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
                          controller: _email,
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          textAlign: TextAlign.center,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter email',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = RegExp(pattern);
                              if (!regExp.hasMatch(value))
                                return ('The email is invalid');
                            } else
                              return null;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: _password,
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
                        FormState formState = _formKey.currentState;
                        if (formState.validate()) {
                          if (!await user.signUp(
                              _name.text, _email.text, _password.text)) {
                            _key.currentState.showSnackBar(SnackBar(
                              content: Text('Sign up failed'),
                            ));
                          } else {
                            Navigator.pushReplacementNamed(
                                context, HomePage.id);
                          }
                        }
                        //validateForm();
                      })
                ],
              ),
            ),
          );
  }
}
