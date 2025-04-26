import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/features/stores/view/widgets/holder_view.dart';
import 'package:fcai_app/features/stores/view/widgets/loading_stores_view.dart';
import 'package:fcai_app/features/stores/view/widgets/stores_list_view.dart';
import 'package:fcai_app/features/stores/viewmodel/stores_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoresListViewBuilder extends StatelessWidget {
  const StoresListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StoresProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return LoadingStoresView();
        } else if (provider.stores.isNotEmpty) {
          return StoresListView(
            nearbyStoresModel: provider.stores,
          );
        } else {
          return SliverToBoxAdapter(
            child: HolderBody(
              icon: const Icon(Icons.location_off,
                  size: 36, color: AppColors.primaryColor),
              title: "No Stores Found",
              message:
                  "Maybe there was a problem with your location, please reload the page to fetch nerby stores.",
              buttonText: "Reload",
              onPressed: () {
                Provider.of<StoresProvider>(context, listen: false)
                    .fetchAndCacheStores(context);
              },
            ),
          );
        }
      },
    );
  }
}
