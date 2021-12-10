import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/componants/round_button.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  static const String id = 'sign up';

  final String onePage;

  SignUp({this.onePage});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureText = true;

  final _formKey2 = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final _key2 = GlobalKey<ScaffoldState>();

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProv authProvider = Provider.of<UserProv>(context);
    var args = ModalRoute.of(context).settings.arguments;
    //TextEditingController _email2 = TextEditingController();

    return Scaffold(
      key: _key2,
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
              key: _formKey2,
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
                    validator: (value) => EmailValidator.validate(value.trim())
                        ? null
                        : "Valid Email is required",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _password,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    textAlign: TextAlign.center,
                    obscureText: _obscureText,
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
              height: 20.0,
            ),
            RoundedButton(
                buttonText: 'Sign up',
                onPressed: () async {
                  //await Firebase.initializeApp();
                  if (_formKey2.currentState.validate()) {
                    showProgress(context, 'Creating new account...', false);
                    if (!await authProvider.signUp(
                        name: _name, email: _email, password: _password)) {
                      hideProgress();

                      showAlertDialog(context, "Error",
                          "SignUp Failed \n\nEmail already in use");
                      hideProgress();

                      return;
                    }
                    hideProgress();
                    //authProvider.clearController();
                    authProvider.reloadUser();

                    ///Check if one page is left in a stack to  avoid pop()
                    args == 'onePage'
                        ? Navigator.pushReplacementNamed(context, HomePage.id)
                        : Navigator.pop(context);
                  } //validateForm();
                })
          ],
        ),
      ),
    );
  }
}
