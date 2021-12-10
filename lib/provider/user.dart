import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProv with ChangeNotifier {
  static const LOGGED_IN = "loggedIn";
  static const ID = "id";

  int _intiScreen;
  User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserModel _userModel;

  //Getter
  int get initScreen => _intiScreen;
  User get user => _user;
  Status get status => _status;
  UserModel get userModel => _userModel;

  //Public variables
  final formKeyLogin = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
//  final formKey2 = GlobalKey<FormState>();
  //final key = GlobalKey<ScaffoldState>();
  //final key2 = GlobalKey<ScaffoldState>();

//  TextEditingController email = TextEditingController();
//  TextEditingController password = TextEditingController();
//  TextEditingController name = TextEditingController();
//
//  // TextEditingController email2 = TextEditingController();
//  TextEditingController password2 = TextEditingController();
//  TextEditingController name2 = TextEditingController();

  UserProv() {
    init();
  }

  init() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _status = Status.Authenticated;
      } else {
        _status = Status.Unauthenticated;
      }
      notifyListeners();
    });
  }

  Future<bool> signIn({var email, var password}) async {
    try {
      _status = Status.Authenticating;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      _status = Status.Authenticated;
      notifyListeners();

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp({var email, var password, var name}) async {
    try {
      _status = Status.Authenticating;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        _userServices.createUser(
          id: result.user.uid,
          name: name.text.trim(),
          email: email.text.trim(),
        );

        // _status = Status.Authenticated;
        await prefs.setString(ID, result.user.uid);
        await prefs.setBool(LOGGED_IN, true);
        // hideProgress();
      });
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (error) {
//      hideProgress();
      _status = Status.Unauthenticated;
      notifyListeners();
      print(error.toString());
      return false;
    }
  }

  Future signOut() async {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  void clearController({var email, var password, var name}) {
    name.text = '';
    email.text = '';
    password.text = '';
  }

  Future<void> reloadUser() async {
    await FirebaseAuth.instance.currentUser.reload();
    notifyListeners();
  }

  updateUserData(Map<String, dynamic> data, String userId) async {
    _userServices.updateUserData(data, userId);
  }

  saveDeviceToken() async {
    FirebaseMessaging fcm = FirebaseMessaging.instance;
    String deviceToken = await fcm.getToken();
    if (deviceToken != null) {
      _userServices.addDeviceToken(deviceToken, user.uid);
    }
  }
}
