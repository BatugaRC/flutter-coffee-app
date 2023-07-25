// ignore_for_file: unused_element

import "package:brew_crew/services/database.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:brew_crew/models/user.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser

  AppUser? _userFromFirebaseUser(final user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      final result = await _auth.signInAnonymously();
      final user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // register with email and password
  Future<bool> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      // create a new document for the user with uid
      await DatabaseService(uid: user!.uid).updateUserData("0", "anonymous", 100);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //sign out
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
