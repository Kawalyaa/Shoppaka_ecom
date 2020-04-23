import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter/cupertino.dart';

class UserServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<String> get onAuthStateChange =>
      _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);

  //=====Email and Password sign up ========
  Future<String> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    final FirebaseUser newUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;

    //=======update the username======
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await newUser.updateProfile(userUpdateInfo);
    await newUser.reload();
    print(newUser.displayName);
    return null;
  }

  //=======sing in user with email and password=========
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final oldUser = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    //check if user signed in
    assert(oldUser != null);
    return oldUser.displayName;
  }

  Future<String> getCurrentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return user.displayName.toString();
  }

  //Sign Out
  signOut() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
    _firebaseAuth.signOut();
  }
}
