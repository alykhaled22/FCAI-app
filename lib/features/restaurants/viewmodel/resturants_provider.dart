import 'package:dio/dio.dart';
import 'package:fcai_app/core/services/location_service.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:fcai_app/features/restaurants/services/nearby_restaurants_api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';

class RestaurantsProvider with ChangeNotifier {
  List<RestaurantsModel> restaurants = [];
  bool isLoading = true;

  static const String boxName = "restaurant";

  Future<void> init(BuildContext context) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<RestaurantsModel>(boxName);
    }

    final box = Hive.box<RestaurantsModel>(boxName);

    if (box.isNotEmpty) {
      restaurants = box.values.toList();
      isLoading = false;
      notifyListeners();
    } else {
      if (!context.mounted) return;
      await fetchAndCacheRestaurants(context);
    }
  }

  Future<void> fetchAndCacheRestaurants(BuildContext context) async {
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

      final response = await NearbyRestaurantsApi(dio: Dio())
          .fetchNearbyRestaurants(latitude, longitude);

      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox<RestaurantsModel>(boxName);
      }

      final box = Hive.box<RestaurantsModel>(boxName);
      await box.clear();

      for (var store in response) {
        await box.add(store);
      }
      restaurants = box.values.toList();
    } catch (e) {
      debugPrint("Error fetching resturants: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  List<RestaurantsModel> get favRestaurants {
    return restaurants.where((store) => store.isFav).toList();
  }

  void toggleFav(RestaurantsModel restaurant) {
    final box = Hive.box<RestaurantsModel>(boxName);

    final index = restaurants.indexOf(restaurant);
    if (index != -1) {
      restaurant.isFav = !restaurant.isFav;
      box.putAt(index, restaurant);
      notifyListeners();
    }
  }

  static void deleteCahcedResturant() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<RestaurantsModel>(boxName);
    }
    final box = Hive.box<RestaurantsModel>(boxName);
    box.clear();
  }
}
