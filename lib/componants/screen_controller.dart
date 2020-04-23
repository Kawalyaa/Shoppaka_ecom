import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/pages/login_options_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:ecommerce_app/pages/splash_screen.dart';

class ScreenController extends StatelessWidget {
  static const String id = 'ScreenColler';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.UNINITIALIZED:
        return SplashScreen();
      case Status.UNAUTHENTICATED:
        return WelcomeLoginOptions();
      //case Status.AUTHENTICATING:
      case Status.AUTHENTICATED:
        return HomePage();
      default:
        return Login();
    }
  }
}
