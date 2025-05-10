import 'package:fcai_app/features/products/view/widgets/prouducts_view_body.dart';
import 'package:fcai_app/features/products/viewmodel/products_provider.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key, required this.restaurantModel});
  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ProductsViewBody(
            restaurantModel: restaurantModel,
          ),
        ),
      ),
    );
  }
}
