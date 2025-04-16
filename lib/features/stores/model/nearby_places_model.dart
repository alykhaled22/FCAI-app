import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class NearbyPlacesModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final double distance;
  @HiveField(3)
  final String category;
  @HiveField(4)
  bool isFav;

  NearbyPlacesModel({
    required this.name,
    required this.address,
    required this.distance,
    required this.category,
    this.isFav = false,
  });

  factory NearbyPlacesModel.fromJson(json) {
    final categories = json["poi"]['categories'] as List<dynamic>? ?? [];

    return NearbyPlacesModel(
      name: json['poi']['name'] ?? "",
      address:
          "${json["address"]['municipality'] ?? ''}, ${json["address"]['countrySecondarySubdivision'] ?? ''}, ${json["address"]['countryCode'] ?? ''}",
      distance: json["dist"] ?? 0.0,
      category: categories.length >= 2
          ? "${categories[0]}, ${categories[1]}"
          : categories.length == 1
              ? "${categories[0]}"
              : "",
    );
  }
}
