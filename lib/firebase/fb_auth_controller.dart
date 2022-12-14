import 'package:firebase_auth/firebase_auth.dart';
import 'package:secand_in_firebase/models/firebase_response.dart';

class FbAuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseResponse> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return FirebaseResponse(success: true, message: '');
    } on FirebaseAuthException catch (authException) {
      return FirebaseResponse(
          success: false, message: authException.message ?? '');
    }
  }

  void _controlException({required FirebaseAuthException authException}) async {
    if (authException.code == 'expired-action-code') {
    } else if (authException.code == 'invalid-action-code') {
    } else if (authException.code == 'user-disabled') {
    } else if (authException.code == 'user-not-found') {}
  }

  Future<FirebaseResponse> createAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return FirebaseResponse(success: true, message: 'Login In Successful');
    } on FirebaseAuthException catch (authException) {
      return FirebaseResponse(
          success: false, message: authException.message ?? '');
    }
  }

  Future<void> signOut() async =>_firebaseAuth.signOut();

  User? get user => _firebaseAuth.currentUser;

  bool get signedIn=>_firebaseAuth.currentUser!=null;

  Future<FirebaseResponse> sendPasswordAndRestEmail({required String email})async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return FirebaseResponse(success: true, message: 'send message successful');
    }on FirebaseAuthException catch(authException){
      return FirebaseResponse(success: false, message: 'send message failed');
    }
  }
}
