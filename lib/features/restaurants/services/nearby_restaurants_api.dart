import 'package:dio/dio.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';

class NearbyRestaurantsApi {
  final Dio dio;

  NearbyRestaurantsApi({required this.dio});

  Future<List<RestaurantsModel>> fetchNearbyRestaurants(
      double latitude, double longitude) async {
    try {
      final response = await dio.get(
        'https://fcai-server-production.up.railway.app/places?user_lat=$latitude&user_lon=$longitude',
      );

      List<RestaurantsModel> nearbyRestaurantsList = [];
      final restaurants = response.data;

      for (var resturant in restaurants) {
        nearbyRestaurantsList.add(RestaurantsModel.fromJson(resturant));
      }

      return nearbyRestaurantsList;
    } catch (e) {
      throw Exception('Failed to load nearby restaurants: $e');
    }
  }
}
