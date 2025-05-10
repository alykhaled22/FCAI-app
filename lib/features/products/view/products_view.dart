import 'package:fcai_app/features/products/view/widgets/products_header.dart';
import 'package:fcai_app/features/products/view/widgets/products_list_view.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:fcai_app/core/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key, required this.restaurantModel});
  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              ProductsHeader(
                title: restaurantModel.name,
                imageUrl: restaurantModel.image,
                address: restaurantModel.address,
              ),
              SizedBox(height: 30),
              CustomSearchBar(hintText: 'Search menu items...',),
              const SizedBox(height: 20),
              Expanded(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [ProductsListView(products: restaurantModel.products)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
