import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 2) 
class ProductModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String category;

  ProductModel({
    required this.name,
    required this.image,
    required this.category,
    required this.price,
  });

  factory ProductModel.fromJson(json) {
    return ProductModel(
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      category: json["category"] ?? "",
      price: (json["price"] as num?)?.toDouble() ?? 0.0,
    );
  }
}
