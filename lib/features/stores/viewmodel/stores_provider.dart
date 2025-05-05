import 'package:dio/dio.dart';
import 'package:fcai_app/core/services/location_service.dart';
import 'package:fcai_app/features/stores/model/store_model.dart';
import 'package:fcai_app/features/stores/services/nearby_stores_api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';

class StoresProvider with ChangeNotifier {
  List<StoreModel> stores = [];
  bool isLoading = true;

  static const String boxName = "stores";

  Future<void> init(BuildContext context) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<StoreModel>(boxName);
    }

    final box = Hive.box<StoreModel>(boxName);

    if (box.isNotEmpty) {
      stores = box.values.toList();
      isLoading = false;
      notifyListeners();
    } else {
      if (!context.mounted) return;
      await fetchAndCacheStores(context);
    }
  }

  Future<void> fetchAndCacheStores(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      Position? location = await LocationService.getCurrentLocation(context);

      if (location == null) {
        isLoading = false;
        notifyListeners();
        return;
      }

      final latitude = location.latitude;
      final longitude = location.longitude;

      final response = await NearbyStoresApi(dio: Dio())
          .fetchNearbyStores(latitude, longitude);

      final box = Hive.box<StoreModel>(boxName);
      await box.clear();

      for (var store in response) {
        await box.add(store);
      }
      stores = box.values.toList();
    } catch (e) {
      debugPrint("Error fetching stores: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  List<StoreModel> get favStores {
    return stores.where((store) => store.isFav).toList();
  }

  void toggleFav(StoreModel store) {
    final box = Hive.box<StoreModel>(boxName);

    final index = stores.indexOf(store);
    if (index != -1) {
      store.isFav = !store.isFav;
      box.putAt(index, store);
      notifyListeners();
    }
  }

  static void deleteCahcedStores() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<StoreModel>(boxName);
    }
    final box = Hive.box<StoreModel>(boxName);
    box.clear();
  }
}
