import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/signup.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/componants/round_button.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String id = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final _key = GlobalKey<ScaffoldState>();

  bool _obscureText = true;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _key = GlobalKey<ScaffoldState>();
  final _formKeyLogin = GlobalKey<FormState>();

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<UserProv>(context);

    return Scaffold(
      //key: _key,
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
              key: _formKeyLogin,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
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
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: _obscureText,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    controller: _password,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _toggleVisibility();
                        },
                        icon: _obscureText
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
                  if (_formKeyLogin.currentState.validate()) {
                    showProgress(context, 'Logging in, please wait...', false);
                    if (!await _authProvider.signIn(
                        email: _email, password: _password)) {
                      hideProgress();
                      showAlertDialog(context, "Error",
                          "Login Failed\n\nIncorrect Email or Password");
                      return;
                    }

                    hideProgress();
                    //_authProvider.clearController();
                    _authProvider.reloadUser();
                    Navigator.pushReplacementNamed(context, HomePage.id);

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
