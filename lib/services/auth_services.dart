//import 'package:firebase_auth/firebase_auth.dart';
//
//class AuthServices {
//  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//  //This will be used to monitor when the user is logged in and out
//  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
//        (FirebaseUser user) => user?.uid,
//      );
//
//  //Email and password sign up
//  Future<String> createUserWithEmailAndPassword(
//      String email, String password, String name) async {
//    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
//        email: email, password: password);
//
//    //Update username
//    var userUpdateInfo = UserUpdateInfo();
//    userUpdateInfo.displayName = name;
//    await currentUser.user.updateProfile(userUpdateInfo);
//    await currentUser.user.reload();
//    return currentUser.user.uid;
//  }
//
//  //Email and password Sign in
//  Future<String> singInWithEmailAndPassword(
//      String email, String password) async {
//    return (await _firebaseAuth.signInWithEmailAndPassword(
//            email: email, password: password))
//        .user
//        .uid;
//  }
//
//  //Sign Out
//  void signOut() {
//    _firebaseAuth.signOut();
//  }
//
////Get current user
//  Future<FirebaseUser> getCurrentUser() async {
//    FirebaseUser user = await _firebaseAuth.currentUser();
//    return user;
//  }
//}
