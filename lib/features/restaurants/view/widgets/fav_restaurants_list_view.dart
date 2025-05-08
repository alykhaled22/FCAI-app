import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/core/viewmodel/navigation_provider.dart';
import 'package:fcai_app/features/restaurants/view/widgets/holder_view.dart';
import 'package:fcai_app/features/restaurants/view/widgets/restaurants_item.dart';
import 'package:fcai_app/features/restaurants/viewmodel/resturants_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavRestaurantsListView extends StatelessWidget {
  const FavRestaurantsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final favRestaurants =
        Provider.of<RestaurantsProvider>(context).favRestaurants;
    final navProvider = Provider.of<NavigationProvider>(context);

    if (favRestaurants.isEmpty) {
      return SliverToBoxAdapter(
        child: HolderBody(
          icon: const Icon(Icons.favorite,
              size: 36, color: AppColors.primaryColor),
          title: "No favorites yet",
          message:
              "Add resturants to your favorites by tapping the heart icon on resturant you like.",
          buttonText: "Browse Resturants",
          onPressed: () {
            navProvider.changeTab(0);
          },
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: favRestaurants.length,
        (context, index) {
          return RestaurantsItem(resturantModel: favRestaurants[index]);
        },
      ),
    );
  }
}
