import 'package:ecommerce_app/componants/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:splashscreen/splashscreen.dart';

class TheSplashScreen extends StatefulWidget {
  static const String id = "theSplashScreen";
  @override
  _TheSplashScreenState createState() => _TheSplashScreenState();
}

class _TheSplashScreenState extends State<TheSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SplashScreen(
        seconds: 1000,
        title: Text(
          "Shopla",
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w900),
        ),
        loaderColor: Colors.white,
        backgroundColor: Color(0xFFFF0025),
      ),
    );
  }
}

//body: Center(
//child: Stack(
//children: [
////Image.asset("images/splash.png", fit: BoxFit.cover),
//Container(
//color: Colors.teal,
//width: double.infinity,
//height: double.infinity,
//),
//SpinKitFadingCircle(
//color: Color(0xFFFF0025),
//size: 30.0,
//),
//],
//),
//),
