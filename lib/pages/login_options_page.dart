import 'package:ecommerce_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:flutter/rendering.dart';
import 'login.dart';
import 'package:ecommerce_app/componants/round_button.dart';
import 'signup.dart';
import '../db/auth.dart';

class WelcomeLoginOptions extends StatefulWidget {
  static const String id = 'welcomeLoginOptions';
  @override
  _WelcomeLoginOptionsState createState() => _WelcomeLoginOptionsState();
}

class _WelcomeLoginOptionsState extends State<WelcomeLoginOptions> {
  bool isLoggedIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Auth auth = Auth();
  UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/fashionHome.jpg',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              //color: Colors.white,
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to Shopla',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  RoundedButton(
                      buttonText: 'SIGN IN',
                      onPressed: () => Navigator.pushNamed(context, Login.id)),
                  SizedBox(
                    height: 20.0,
                  ),
                  RoundedButton(
                      buttonText: 'CREATE AN ACCOUNT',
                      onPressed: () => Navigator.pushNamed(context, SignUp.id)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'or',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: _signInButton(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _signInButton() => OutlineButton(
        splashColor: Colors.grey,
        onPressed: () async {
          User user = await auth.googleSignIn();
          User currentUser = _auth.currentUser;
          //create user if does not exit
          if (currentUser == null) {
            _userServices.createUser(
                name: user.displayName,
                photo: user.photoURL,
                email: user.email,
                id: user.uid);
          }
          Navigator.pushReplacementNamed(context, HomePage.id);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Container(
            width: 230.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage(
                    'images/google_logo.png',
                  ),
                  height: 28.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(color: Colors.grey, fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget roundButton(String text, Function pageRoute) {
    return Material(
      color: Color(0xFFFF0025),
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: pageRoute,
        minWidth: 250.0,
        height: 35.0,
        child: Text(
          text,
          style: TextStyle(color: Color(0xFFFED0E5), fontSize: 16.0),
        ),
      ),
    );
  }
}
