import 'package:fcai_app/core/widgets/custom_search_bar.dart';
import 'package:fcai_app/features/products/view/widgets/products_header.dart';
import 'package:fcai_app/features/products/view/widgets/products_list_view.dart';
import 'package:fcai_app/features/products/viewmodel/products_provider.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsViewBody extends StatelessWidget {
  const ProductsViewBody({super.key, required this.restaurantModel});

  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          ProductsHeader(
            restaurantModel: restaurantModel,
          ),
          SizedBox(height: 30),
          CustomSearchBar(
            onChanged: (query) =>
                provider.searchProducts(query, restaurantModel),
            hintText: 'Search menu items...',
          ),
          const SizedBox(height: 20),
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                ProductsListView(
                    products: provider.filteredProducts.isNotEmpty ||
                            provider.productSearchText.isNotEmpty
                        ? provider.filteredProducts
                        : restaurantModel.products)
              ],
            ),
          )
        ],
      ),
    );
  }
}
