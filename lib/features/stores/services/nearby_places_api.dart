import 'package:dio/dio.dart';
import 'package:fcai_app/features/stores/model/nearby_places_model.dart';

class NearbyPlacesApi {
  final Dio dio;

  NearbyPlacesApi({required this.dio});

  Future<List<NearbyPlacesModel>> fetchNearbyPlaces(
      double latitude, double longitude) async {
    try {
      final response = await dio.get(
        'https://api.tomtom.com/search/2/nearbySearch/.json?key=2LbpD11zrDIpluLFEKOHVV6JPwSzhMvi&lat=36.98844&lon=-121.97483&radius=5000&categorySet=9361,7315,7332&limit=50',
      );

      Map<String, dynamic> jsonData = response.data;
      List<dynamic> nearbyPlaces = jsonData["results"];

      List<NearbyPlacesModel> nearbyPlacesList = [];

      for (var place in nearbyPlaces) {
        nearbyPlacesList.add(NearbyPlacesModel.fromJson(place));
      }

      return nearbyPlacesList;
    } catch (e) {
      throw Exception('Failed to load nearby places: $e');
    }
  }
}
