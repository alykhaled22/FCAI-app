import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class FirebaseService {
  final FirebaseAuth userAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      UserModel user, BuildContext context) async {
    try {
      final currentUser = await userAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      final id = currentUser.user?.uid;

      await firestore.collection("users").doc(id).set({
        "name": user.name,
        "id": user.id,
        "email": user.email,
        "gender": user.gender,
        "level": user.level,
        "imageUrl": user.imageUrl,
      });
      return currentUser.user;
    } on FirebaseAuthException catch (e) {
      final message = handleFirebaseAuthError(e);
      if (!context.mounted) return null;
      Helpers.showErrorSnackBar(context, message);
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final currentUser = await userAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return currentUser.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      final message = handleFirebaseAuthError(e);
      if (!context.mounted) return null;
      Helpers.showErrorSnackBar(context, message);
    }
    return null;
  }

  Future<UserModel?> getCurrentUser(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;
    final id = user.uid;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    if (!doc.exists) return null;

    final data = doc.data()!;
    return UserModel(
      name: data['name'] ?? "",
      id: data['id'] ?? "",
      email: data['email'] ?? "",
      password: "",
      gender: data['gender'] ?? "",
      level: data['level'] ?? "",
      imageUrl: data['imageUrl'] ?? "",
    );
  }

  Future<bool> updateUserData(UserModel user, BuildContext context) async {
    try {
      final id = userAuth.currentUser?.uid;
      if (id == null) return false;

      await firestore.collection("users").doc(id).update({
        "name": user.name,
        "id": user.id,
        "email": user.email,
        "imageUrl": user.imageUrl,
        "level": user.level,
        "gender": user.gender,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserPassword(String password, BuildContext context) async {
    try {
      final user = userAuth.currentUser;
      if (user == null) return false;

      await user.updatePassword(password);
      return true;
    } on FirebaseAuthException catch (e) {
      final message = handleFirebaseAuthError(e);
      if (!context.mounted) return false;
      Helpers.showErrorSnackBar(context, message);
      return false;
    } catch (e) {
      if (!context.mounted) return false;
      Helpers.showErrorSnackBar(
          context, "An error occurred. Please try again.");
      return false;
    }
  }

  bool isUserLoggedIn() {
    return userAuth.currentUser != null;
  }

  Future<void> logoutUser() async {
    await userAuth.signOut();
  }

  Future<bool> checkInternetConnection(BuildContext context) async {
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;
    if (!isConnected) {
      if (!context.mounted) return false;
      Helpers.showErrorSnackBar(
          context, "Please check your internet connection.");
    }
    return isConnected;
  }

  String handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return "Wrong email or password, Please try again.";
      case 'user-not-found':
        return "No user found for that email.";
      case 'wrong-password':
        return "Wrong password.";
      case 'email-already-in-use':
        return "The email address is already in use by another account.";
      case 'invalid-email':
        return "The email address is badly formatted.";
      case 'requires-recent-login':
        return "Please log in again to perform this action.";
      default:
        return "An undefined Error happened.";
    }
  }
}
