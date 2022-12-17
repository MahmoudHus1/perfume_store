import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../app_router/app_router.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<String?> signUp(String email, String pass) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      return userCredential.user!.uid;
    } on Exception catch (e) {
      AppRouter.appRouter
          .showCustomDialoug('Error in registeration', e.toString());
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid;
    } on Exception catch (e) {
      AppRouter.appRouter
          .showCustomDialoug('Error in Authentication', e.toString());
    }
  }

  String? checkUser() {
    User? user = firebaseAuth.currentUser;
    return user?.uid;
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}
