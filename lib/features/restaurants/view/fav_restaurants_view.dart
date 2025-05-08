import 'package:fcai_app/features/restaurants/view/widgets/fav_restaurants_list_view.dart';
import 'package:fcai_app/features/restaurants/view/widgets/restaurants_view_header.dart';
import 'package:flutter/material.dart';

class FavRestaurantsView extends StatelessWidget {
  const FavRestaurantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          RestaurantsViewHeader(
            title: "Favorite Restaurants",
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                FavRestaurantsListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
