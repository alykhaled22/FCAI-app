import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/features/restaurants/view/widgets/holder_view.dart';
import 'package:fcai_app/features/restaurants/view/widgets/loading_resturant_view.dart';
import 'package:fcai_app/features/restaurants/view/widgets/restaurants_list_view.dart';
import 'package:fcai_app/features/restaurants/viewmodel/resturants_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantsListViewBuilder extends StatelessWidget {
  const RestaurantsListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return LoadingResturantsView();
        } else if (provider.restaurants.isNotEmpty) {
          final displayedRestaurants =
              provider.filteredRestaurants.isNotEmpty ||
                      provider.resSearchText.isNotEmpty
                  ? provider.filteredRestaurants
                  : provider.restaurants;
          return RestaurantsListView(
            restaurantsModel: displayedRestaurants,
          );
        } else {
          return SliverToBoxAdapter(
            child: HolderBody(
              icon: const Icon(Icons.location_off,
                  size: 36, color: AppColors.primaryColor),
              title: "No Restaurants Found",
              message:
                  "Maybe there was a problem with your location, please reload the page to fetch nerby restaurants.",
              buttonText: "Reload",
              onPressed: () {
                Provider.of<RestaurantsProvider>(context, listen: false)
                    .fetchAndCacheRestaurants(context);
              },
            ),
          );
        }
      },
    );
  }
}
