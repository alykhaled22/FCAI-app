import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/features/products/model/product_model.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService<T> {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(RestaurantsModelAdapter());
    Hive.registerAdapter(ProductModelAdapter());
  }

  Future<Box<T>> openBox({required String boxName}) async {
    return await Hive.openBox<T>(boxName);
  }

  bool isBoxOpen({required String boxName}) {
    return Hive.isBoxOpen(boxName);
  }

  Future<void> putData(
      {required Box<T> box, required String key, required T value}) async {
    await box.put(key, value);
  }

  T? getData({required Box<T> box, required String key}) {
    return box.get(key);
  }

  Future<void> deleteData({required Box<T> box, required String key}) async {
    await box.delete(key);
  }
}
