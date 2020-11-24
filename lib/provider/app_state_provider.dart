//import 'package:ecommerce_app/componants/screen_controller.dart';
//import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//
//class ApplicationState extends ChangeNotifier {
//  ApplicationLoginState _loginState = ApplicationLoginState.WELCOME;
//  FirebaseAuth _auth;
//  FirebaseAuth get auth => _auth;
//  ApplicationLoginState get loginState => _loginState;
//
//  ApplicationState() {
//    init();
//  }
//
//  Future<void> init() async {
//    await Firebase.initializeApp();
//    FirebaseAuth.instance.userChanges().listen((user) {
//      if (user != null) {
//        _loginState = ApplicationLoginState.LOGGEDIN;
//      } else {
//        _loginState = ApplicationLoginState.LOGGEDOUT;
//      }
//    });
//  }
//
//  void signInWithEmailAndPassword(
//    String email,
//    String password,
//    void Function(FirebaseAuthException e) errorCallback,
//  ) async {
//    _loginState = ApplicationLoginState.AUTHENTICATING;
//
//    try {
//      FirebaseAuth.instance
//          .signInWithEmailAndPassword(email: email, password: password);
//    } on Exception catch (e) {
//      errorCallback(e);
//    }
//    _loginState = ApplicationLoginState.LOGGEDIN;
//  }
//
//  void registerAccount(String email, String name, String password,
//      void Function(FirebaseAuthException e) errorCallback,
//      {String photoUrl = 'No photo'}) async {
//    _loginState = ApplicationLoginState.AUTHENTICATING;
//
//    try {
//      var credential = await FirebaseAuth.instance
//          .createUserWithEmailAndPassword(email: email, password: password);
//      await credential.user
//          .updateProfile(displayName: name, photoURL: photoUrl);
//    } on FirebaseAuthException catch (e) {
//      errorCallback(e);
//    }
//    _loginState = ApplicationLoginState.LOGGEDIN;
//  }
//
//  void signOut() {
//    FirebaseAuth.instance.signOut();
//  }
//
//  User getCurrentUser() {
//    User user = FirebaseAuth.instance.currentUser;
//    return user;
//  }
//}
//
//
