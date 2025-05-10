import 'package:fcai_app/features/products/model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'restaurant_model.g.dart';

@HiveType(typeId: 1)
class RestaurantModel extends HiveObject {
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
  @HiveField(5)
  final double latitude;
  @HiveField(6)
  final double longitude;
  @HiveField(7)
  final String image;
  @HiveField(8)
  final List<ProductModel> products;

  RestaurantModel({
    required this.name,
    required this.address,
    required this.distance,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.products,
    this.isFav = false,
  });

  factory RestaurantModel.fromJson(json) {
    return RestaurantModel(
      name: json['name'] ?? "",
      address: json["address"] ?? "",
      distance: (json['distance_km'] ?? 0.0) as double,
      category: json["category"] ?? "",
      latitude: (json['latitude'] ?? 0.0) as double,
      longitude: (json['longitude'] ?? 0.0) as double,
      image: json["image"] ?? "",
      products: (json['products'] as List)
          .map((p) => ProductModel.fromJson(p))
          .toList(),
    );
  }
}
