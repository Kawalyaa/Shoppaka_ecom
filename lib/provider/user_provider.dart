import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../db/userServices.dart';

enum Status { UNINITIALIZED, AUTHENTICATED, AUTHENTICATING, UNAUTHENTICATED }

class UserProvider with ChangeNotifier {
  UserServices _userServices = UserServices();
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.UNINITIALIZED;

  Status get status => _status;
  FirebaseUser get user => _user;

  //UserProvider constructor
  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }
  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.AUTHENTICATING;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      //_status = Status.AUTHENTICATED;
      //notifyListeners();
      return true;
    } catch (e) {
      _status = Status.UNAUTHENTICATED;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.AUTHENTICATING;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        Map<String, dynamic> value = {
          'name': name,
          'email': email,
          'userId': user.user.uid
        };
        _userServices.createUser(value);
        //_status = Status.AUTHENTICATED;
        //notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.UNAUTHENTICATED;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  void signOut() {
    _auth.signOut();
    // _status = Status.UNAUTHENTICATED;
    notifyListeners();
    //return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.UNAUTHENTICATED;
    } else {
      user = _user;
      _status = Status.AUTHENTICATED;
    }
    notifyListeners();
  }
}
