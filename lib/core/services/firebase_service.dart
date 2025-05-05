import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      final message = handleFirebaseAuthError(e);
      if (!context.mounted) return null;
      Helpers.showErrorSnackBar(context, message);
    }
    return null;
  }

  Future<void> chaceUesrData(UserModel user) async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox<UserModel>("user");
    }
    final box = Hive.box<UserModel>("user");
    await box.clear();
    await box.add(user);
  }

  Future<UserModel?> getCurrentUser(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;
    final id = user.uid;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    if (!doc.exists) return null;

    final data = doc.data()!;
    final userModel = UserModel(
      name: data['name'] ?? "",
      id: data['id'] ?? "",
      email: data['email'] ?? "",
      password: "",
      gender: data['gender'] ?? "",
      level: data['level'] ?? "",
      imageUrl: data['imageUrl'] ?? "",
    );
    await chaceUesrData(userModel);
    return userModel;
  }

  Future<UserModel> loadCachedUser() async {
    if (!Hive.isBoxOpen("user")) {
      await Hive.openBox<UserModel>("user");
    }
    final box = Hive.box<UserModel>("user");
    if (box.isEmpty) return UserModel.empty();
    return box.getAt(0)!;
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
      chaceUesrData(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserPassword(
      String newPassword, String oldPassword, BuildContext context) async {
    try {
      final user = userAuth.currentUser;
      if (user == null) return false;

      // Reauthenticate the user
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        ),
      );

      await user.updatePassword(newPassword);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        if (!context.mounted) return false;
        Helpers.showErrorSnackBar(context, "Wrong password, Please try again.");
        return false;
      } else {
        final message = handleFirebaseAuthError(e);
        if (!context.mounted) return false;
        Helpers.showErrorSnackBar(context, message);
        return false;
      }
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
