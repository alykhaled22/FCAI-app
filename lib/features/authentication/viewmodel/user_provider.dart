import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final HiveService hiveService = HiveService<UserModel>();
  late UserModel currentUser;

  Future<bool> loginUser(String email, String password) async {
    final boxName = "user";
    final box = !hiveService.isBoxOpen(boxName: boxName)
        ? await hiveService.openBox(boxName: boxName)
        : Hive.box<UserModel>(boxName);

    final user = hiveService.getData(box: box, key: email);

    if (user == null || user.password != password) {
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('loggedInUserEmail', email);
    currentUser = user;
    return true;
  }

  Future<bool> isUserExists(String email) async {
    final boxName = "user";
    final box = !hiveService.isBoxOpen(boxName: boxName)
        ? await hiveService.openBox(boxName: boxName)
        : Hive.box<UserModel>(boxName);
    if (box.containsKey(email)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> registerUser(UserModel user, String email) async {
    final boxName = "user";
    final box = !hiveService.isBoxOpen(boxName: boxName)
        ? await hiveService.openBox(boxName: boxName)
        : Hive.box<UserModel>(boxName);
    await hiveService.putData(box: box, key: user.email, value: user);
  }

  Future<void> updateUser(
      UserModel user, String updatedEmail, String oldEmail) async {
    final boxName = "user";
    final box = !hiveService.isBoxOpen(boxName: boxName)
        ? await hiveService.openBox(boxName: boxName)
        : Hive.box<UserModel>(boxName);

    if (updatedEmail != oldEmail) {
      await hiveService.deleteData(box: box, key: oldEmail);
    }

    currentUser = user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUserEmail', updatedEmail);

    await hiveService.putData(box: box, key: user.email, value: user);
    notifyListeners();
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('loggedInUserEmail');

    currentUser = UserModel(
      name: "",
      id: "",
      email: "",
      password: "",
    );
  }

  Future<bool> checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> loadCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('loggedInUserEmail');

    if (email != null) {
      final boxName = "user";
      final box = !hiveService.isBoxOpen(boxName: boxName)
          ? await hiveService.openBox(boxName: boxName)
          : Hive.box<UserModel>(boxName);

      final user = hiveService.getData(box: box, key: email);
      if (user != null) {
        currentUser = user;
      }
    }
  }
}
