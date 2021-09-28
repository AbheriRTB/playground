import 'package:chalk_and_duster/models/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // create user obj based on firebase user
  Users? _userFromFirebaseUser(User? user) {
    return user != null
        ? Users(
            uid: user.uid,
            email: user.email,
          )
        : null;
  }

  // auth change user stream
  Stream<Users?> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // SignIn with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(
    UsersData usersData,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: usersData.email!,
        password: password,
      );
      User? user = result.user;
      DatabaseService(uid: user!.uid)
          .updateUserData(UsersData(
            displayName: usersData.displayName,
            email: usersData.email,
            orgId: usersData.orgId,
            mobileNo: usersData.mobileNo,
            photoUrl: usersData.photoUrl,
            isAdmin: usersData.isAdmin,
            isTeacher: usersData.isTeacher,
          ))
          .then((value) => null);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _auth.currentUser;
  }

  // Forgot Password
  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  // SignOut
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
