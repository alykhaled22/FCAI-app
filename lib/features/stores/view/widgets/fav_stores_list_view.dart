import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/core/viewmodel/navigation_provider.dart';
import 'package:fcai_app/features/stores/view/widgets/holder_view.dart';
import 'package:fcai_app/features/stores/view/widgets/store_item.dart';
import 'package:fcai_app/features/stores/viewmodel/stores_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavStoresListView extends StatelessWidget {
  const FavStoresListView({super.key});

  @override
  Widget build(BuildContext context) {
    final favStores = Provider.of<StoresProvider>(context).favStores;
    final navProvider = Provider.of<NavigationProvider>(context);

    if (favStores.isEmpty) {
      return SliverToBoxAdapter(
        child: HolderBody(
          icon: const Icon(Icons.favorite,
              size: 36, color: AppColors.primaryColor),
          title: "No favorites yet",
          message:
              "Add stores to your favorites by tapping the heart icon on stores you like.",
          buttonText: "Browse Stores",
          onPressed: () {
            navProvider.changeTab(0);
          },
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: favStores.length,
        (context, index) {
          return StoreItem(nearbyPlacesModel: favStores[index]);
        },
      ),
    );
  }
}
