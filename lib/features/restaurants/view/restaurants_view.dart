import 'package:fcai_app/core/utils/helpers.dart';
import 'package:fcai_app/features/restaurants/view/widgets/restaurants_list_view_builder.dart';
import 'package:fcai_app/features/restaurants/view/widgets/restaurants_view_header.dart';
import 'package:fcai_app/features/restaurants/viewmodel/resturants_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantsView extends StatelessWidget {
  const RestaurantsView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          RestaurantsViewHeader(
            title: "Restaurants",
            onChanged: provider.searchRestaurantsByProduct,
          ),
          Expanded(
            child: RefreshIndicator(
              backgroundColor: Colors.white,
              onRefresh: () async {
                return await Future.delayed(
                  Duration(seconds: 1),
                  () async {
                    if (!context.mounted) return;
                    await Provider.of<RestaurantsProvider>(context,
                            listen: false)
                        .fetchAndCacheRestaurants(context);
                    if (!context.mounted) return;
                    Helpers.checkInternetConnection(context);
                  },
                );
              },
              child: CustomScrollView(
                slivers: [
                  RestaurantsListViewBuilder(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
