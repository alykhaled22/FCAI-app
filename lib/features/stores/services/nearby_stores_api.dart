import 'package:dio/dio.dart';
import 'package:fcai_app/features/stores/model/store_model.dart';

class NearbyStoresApi {
  final Dio dio;

  NearbyStoresApi({required this.dio});

  Future<List<StoreModel>> fetchNearbyStores(
      double latitude, double longitude) async {
    try {
      final response = await dio.get(
        'https://api.tomtom.com/search/2/nearbySearch/.json?key=2LbpD11zrDIpluLFEKOHVV6JPwSzhMvi&lat=$latitude&lon=$longitude&radius=10000&categorySet=9361,7315,7332&limit=50',
      );

      Map<String, dynamic> jsonData = response.data;
      List<dynamic> nearbyPlaces = jsonData["results"];

      List<StoreModel> nearbyPlacesList = [];

      for (var place in nearbyPlaces) {
        nearbyPlacesList.add(StoreModel.fromJson(place));
      }

      return nearbyPlacesList;
    } catch (e) {
      throw Exception('Failed to load nearby places: $e');
    }
  }
}
