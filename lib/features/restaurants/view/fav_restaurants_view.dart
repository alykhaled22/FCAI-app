import 'package:fcai_app/features/restaurants/view/widgets/fav_restaurants_list_view.dart';
import 'package:flutter/material.dart';

class FavRestaurantsView extends StatelessWidget {
  const FavRestaurantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border_outlined,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Favorite Restaurants",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'GT Sectra Fine',
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
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
