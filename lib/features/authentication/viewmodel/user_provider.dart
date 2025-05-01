import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/firebase_service.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:fcai_app/core/utils/helpers.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final HiveService hiveService = HiveService<UserModel>();
  late UserModel currentUser;
  final FirebaseService firebaseService = FirebaseService();
  bool isLoading = false;

  Future<bool> loginUser(
      String email, String password, BuildContext context) async {
    final connection = await firebaseService.checkInternetConnection(context);
    if (!connection || !context.mounted) return false;

    isLoading = true;
    notifyListeners();

    final user = await firebaseService.signInWithEmailAndPassword(
        email, password, context);

    isLoading = false;
    notifyListeners();

    if (user == null) return false;

    if (!context.mounted) return false;
    Helpers.showSuccessSnackBar(context, "Logged in scuccessfully!");
    return true;
  }

  Future<bool> registerUser(UserModel user, BuildContext context) async {
    final connection = await firebaseService.checkInternetConnection(context);
    if (!connection || !context.mounted) return false;

    isLoading = true;
    notifyListeners();

    final regUser =
        await firebaseService.signUpWithEmailAndPassword(user, context);
    isLoading = false;
    notifyListeners();

    if (regUser == null) {
      return false;
    }

    if (!context.mounted) return false;
    Helpers.showSuccessSnackBar(context, "Signed up scuccessfully!");
    return true;
  }

  Future<bool> updateUser(UserModel user, BuildContext context) async {
    final connection = await firebaseService.checkInternetConnection(context);
    if (!connection || !context.mounted) return false;

    isLoading = true;
    notifyListeners();

    final success = await firebaseService.updateUserData(user, context);

    isLoading = false;
    notifyListeners();

    if (!success) {
      if (!context.mounted) return false;
      Helpers.showErrorSnackBar(
          context, "An error occurred. Please try again.");
      return false;
    }

    return success;
  }

  Future<bool> updateUserPass(
      String newPassword, String oldPassword, BuildContext context) async {
    final connection = await firebaseService.checkInternetConnection(context);
    if (!connection || !context.mounted) return false;

    isLoading = true;
    notifyListeners();

    final success = await firebaseService.updateUserPassword(
        newPassword, oldPassword, context);
        
    isLoading = false;
    notifyListeners();
    return success;
  }

  bool checkLoginState() {
    return firebaseService.isUserLoggedIn();
  }

  Future<void> loadCurrentUser(BuildContext context) async {
    final connection =
        await firebaseService.checkInternetConnection(context, showMsg: false);
    if (!connection) {
      currentUser = await firebaseService.loadCachedUser();
    } else {
      if (!context.mounted) return;
      final userModel = await firebaseService.getCurrentUser(context);
      if (userModel != null) {
        currentUser = userModel;
        notifyListeners();
      }
    }
  }

  void logoutUser() async {
    await firebaseService.logoutUser();
    currentUser = UserModel(
      name: "",
      id: "",
      email: "",
      password: "",
    );
  }
}
