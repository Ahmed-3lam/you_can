import 'package:firebase_auth/firebase_auth.dart';
import 'package:you_can/Models/user.dart';

abstract class AuthBase {
  bool get isNewUser;
  set isNewUser(bool isNewUser);
  Stream<MyUser> get onAuthStateChanged;
  Future<MyUser> currentUser();
  Future<MyUser> signInAnonymously();
  Future<MyUser> signInWithEmailAndPassword(String email, String password);
  Future<MyUser> createUserWithEmailAndPassword(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  MyUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return MyUser(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
    );
  }

  @override
  bool isNewUser;

  @override
  Stream<MyUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<MyUser> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<MyUser> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<MyUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(authResult.user);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  @override
  Future<MyUser> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(authResult.user);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }
}
