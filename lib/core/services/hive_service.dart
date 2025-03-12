import 'package:fcai_app/core/models/user_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
  }

  Future<Box<UserModel>> openBox({required String boxName}) async {
    return await Hive.openBox<UserModel>(boxName);
  }

  bool isBoxOpen({required String boxName}) {
    return Hive.isBoxOpen(boxName);
  }

  Future<void> putData(
      {required Box box, required String key, required dynamic value}) async {
    await box.put(key, value);
  }

  UserModel? getData({required Box box, required String key}) {
    return box.get(key);
  }

  Future<void> deleteData({required Box box, required String key}) async {
    await box.delete(key);
  }

  Future<void> clearBox({required Box box}) async {
    await box.clear();
  }

  Future<void> closeBox({required Box box}) async {
    await box.close();
  }

  Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}
