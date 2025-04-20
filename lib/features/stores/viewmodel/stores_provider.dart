import 'package:dio/dio.dart';
import 'package:fcai_app/features/stores/model/store_model.dart';
import 'package:fcai_app/features/stores/services/nearby_stores_api.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class StoresProvider with ChangeNotifier {
  List<StoreModel> stores = [];
  bool isLoading = false;

  static const String boxName = "stores";

  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<StoreModel>(boxName);
    }

    final box = Hive.box<StoreModel>(boxName);

    if (box.isNotEmpty) {
      stores = box.values.toList();
      notifyListeners();
    } else {
      await fetchAndCacheStores();
    }
  }

  Future<void> fetchAndCacheStores() async {
    isLoading = true;
    notifyListeners();

    try {
      final response =
          await NearbyStoresApi(dio: Dio()).fetchNearbyStores(0.0, 0.0);      

      final box = Hive.box<StoreModel>(boxName);
      await box.clear();

      for (var store in response) {
        await box.add(store);
      }
      stores = box.values.toList();

    } catch (e) {
      print("Error fetching stores: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
