import 'package:fcai_app/features/products/model/product_model.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel> filteredProducts = [];
  String productSearchText = '';

  void searchProducts(String query, RestaurantModel restaurant) {
    productSearchText = query;

    if (query.isEmpty) {
      filteredProducts = [];
    } else {
      final lowerQuery = query.toLowerCase();

      filteredProducts = restaurant.products.where((product) {
        return product.name.toLowerCase().contains(lowerQuery);
      }).toList();
    }
    notifyListeners();
  }
}
