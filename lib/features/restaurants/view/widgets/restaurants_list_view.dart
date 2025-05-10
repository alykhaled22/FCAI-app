import 'package:fcai_app/features/products/view/products_view.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:fcai_app/features/restaurants/view/widgets/restaurants_item.dart';
import 'package:flutter/material.dart';

class RestaurantsListView extends StatelessWidget {
  const RestaurantsListView({super.key, required this.restaurantsModel});
  final List<RestaurantModel> restaurantsModel;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: restaurantsModel.length, (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsView(
                  restaurantModel: restaurantsModel[index],
                ),
              ));
        },
        child: RestaurantsItem(
          restaurantModel: restaurantsModel[index],
        ),
      );
    }));
  }
}
