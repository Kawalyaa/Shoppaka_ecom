import 'package:ecommerce_app/componants/loading.dart';
import 'package:ecommerce_app/model/users.dart';
import 'package:ecommerce_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

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
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final key = GlobalKey<ScaffoldState>();
  final key2 = GlobalKey<ScaffoldState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

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

  Future<bool> signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) async {
        _intiScreen = prefs.getInt("initScreen");
        await prefs.setInt("initScreen", 1);
        // hideProgress();
      });
      return true;
    } catch (e) {
      //hideProgress();
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _intiScreen = prefs.getInt("initScreen");
        await prefs.setInt("initScreen", 1);
        _userServices.createUser(
          id: result.user.uid,
          name: name.text.trim(),
          email: email.text.trim(),
          phone: phone.text.trim(),
        );

        _status = Status.Authenticated;
        await prefs.setString(ID, result.user.uid);
        await prefs.setBool(LOGGED_IN, true);
        // hideProgress();
      });
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ID, null);
    await prefs.setBool(LOGGED_IN, false);
    FirebaseAuth.instance.signOut();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = '';
    email.text = '';
    password.text = '';
    phone.text = '';
  }

  Future<void> reloadUser() async {
    //************ _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  updateUserData(Map<String, dynamic> data, String userId) async {
    _userServices.updateUserData(data, userId);
  }

  saveDeviceToken() async {
    FirebaseMessaging fcm = FirebaseMessaging();
    String deviceToken = await fcm.getToken();
    if (deviceToken != null) {
      _userServices.addDeviceToken(deviceToken, user.uid);
    }
  }
}
