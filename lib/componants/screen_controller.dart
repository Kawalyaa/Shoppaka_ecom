import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/pages/login_options_page.dart';
import 'package:ecommerce_app/pages/signup.dart';
import 'package:ecommerce_app/provider/app_state_provider.dart';
import 'package:ecommerce_app/provider/user.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:ecommerce_app/pages/splash_screen.dart';

class ScreenController extends StatelessWidget {
  static const String id = 'ScreenColler';

  @override
  Widget build(BuildContext context) {
    UserProv auth = Provider.of<UserProv>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return TheSplashScreen();
      case Status.Unauthenticated:
        return Login();
      //case Status.Authenticating:
      case Status.Authenticated:
        return HomePage();
      default:
        return Login();
    }
  }
}
