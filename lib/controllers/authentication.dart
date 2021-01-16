import 'package:all_paws/models/user.dart';
import 'package:all_paws/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();
User0 user = User0();
final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<User> googleSignIn() async {
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
    return user;
  }
}

Future<User> signIn(String email, String password) async {
  try {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isLoggedIn', true);
    return user;
  } catch (e) {}
}

Future<User> signUp(String email, String password) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return user;
  } catch (e) {}
}

Future<User> signOutUser() async {
  User user = auth.currentUser;

  await gooleSignIn.disconnect().whenComplete(() async {
    await auth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('isLoggedIn');
  });

  return user;
}

Future<bool> authenticateUser(User user) async {
  QuerySnapshot result = await FirebaseFirestore.instance
      .collection("users")
      .where("email", isEqualTo: user.email)
      .get();

  final List<DocumentSnapshot> docs = result.docs;
  return docs.length == 0 ? true : false;
}

Future<void> addDataToDb(User currentUser) async {
  String username = Util.getUserName(currentUser.email);

  user = User0(
    uid: currentUser.uid,
    email: currentUser.email,
    name: currentUser.displayName,
    profilePhoto: currentUser.photoURL,
    username: username,
  );

  FirebaseFirestore.instance
      .collection("users")
      .doc(currentUser.uid)
      .set(user.toMap(user, "", "", "", ""));
}
