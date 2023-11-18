
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        print("Google Sign-In Successful: ${user.displayName}");
        final displayName = user.displayName;
        final email = user.email;
        final photoURL = user.photoURL;
        final sharedPrefs = await SharedPreferences.getInstance();
        sharedPrefs.setString('displayName', displayName!);
        sharedPrefs.setString('email', email!);
        sharedPrefs.setString('photoURL', photoURL!);
        sharedPrefs.setBool('isLoggedIn', true);
        Navigator.pop(context);



      }
    }
  } catch (error) {
    print("Google Sign-In Error: $error");
  }
}

