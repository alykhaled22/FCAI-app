import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/core/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

    await hiveService.putData(box: box, key: user.email, value: user);
    notifyListeners();
  }
}
