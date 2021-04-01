import 'package:firebase_auth/firebase_auth.dart';
import 'package:chalk_board/models/user.dart';
import 'package:chalk_board/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String uid;

  // create user obj based on firebase user
  Users _userFromFirebaseUser(User user) {
    return user != null
        ? Users(
            uid: user.uid,
            displayName: user.displayName,
            email: user.email,
            bio: '',
            posts: '',
            username: '',
          )
        : null;
  }

  // auth change user stream
  Stream<Users> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon(String name) async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(name, "NO EMAIL");
      uid = user.uid;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      uid = user.uid;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(name, email);
      uid = user.uid;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // SignIn with Google
  Future signInWithGoogle() async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(account.id)
        .get();
    if (!doc.exists) {
      await DatabaseService(uid: account.id).updateUserData(
        account.displayName,
        account.email,
      );
      return (await _auth.signInWithCredential(credential)).user.uid;
    }
  }

  // Forgot Password
  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  // get UID
  Future<String> getUID() async {
    return (await _auth.currentUser).uid;
  }

/*
  Future addData(String where, String what, String date) async {
    await DatabaseService(uid: (await _auth.currentUser).uid)
        .addWhere(where, what, date);
  }
*/
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
