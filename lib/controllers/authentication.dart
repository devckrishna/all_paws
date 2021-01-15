import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

Future<bool> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();
  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = await auth.signInWithCredential(credential);

    User user = auth.currentUser;
    print(user.uid);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isLoggedIn', true);
    return Future.value(true);
  }
}

Future<bool> signIn(String email, String password) async {
  try {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isLoggedIn', true);
    return Future.value(true);
  } catch (e) {}
}

Future<bool> signUp(String email, String password) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return Future.value(true);
  } catch (e) {}
}

Future<bool> signOutUser() async {
  User user = auth.currentUser;

  await gooleSignIn.disconnect().whenComplete(() async {
    await auth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('isLoggedIn');
  });

  return Future.value(true);
}
