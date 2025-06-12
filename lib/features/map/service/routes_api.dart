import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutesApi {
  static Future<List<LatLng>> getRouteFromORS(LatLng start, LatLng end) async {
    final apiKey = "5b3ce3597851110001cf6248063fa983196d47f78ded12c729fc7a76";

    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}';

    final response = await Dio().get(url);

    final coordinates = response.data['features'][0]['geometry']['coordinates'];

    return coordinates
        .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
        .toList();
  }
}
