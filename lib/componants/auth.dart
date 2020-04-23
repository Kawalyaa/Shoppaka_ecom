import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
SharedPreferences preferences;
bool loading = false;
bool isLoggedIn = false;

Future<FirebaseUser> signInWithGoogle() async {
  FirebaseUser currentUser;
  loading = true;
  try {
    //Google auth
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //Save or Sign in google user to firebase
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    //validate firebase user
    assert(user.email != null);
    assert(user.displayName != null);
    //Account has to be linked to google,
    //not user to sign in anonymously
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    //check for current user
    currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    print(currentUser);
    print("User Name : ${currentUser.displayName}");
  } catch (e) {
    print(e);
  }
  return currentUser;
}

void signOutGoogle() async {
  //Logout user
  await googleSignIn.signOut();
  print('User Signed Out');
}
