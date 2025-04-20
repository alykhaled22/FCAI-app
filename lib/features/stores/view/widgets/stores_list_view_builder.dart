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
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (provider.stores.isNotEmpty) {
          return StoresListView(
            nearbyStoresModel: provider.stores,
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("Oops, no stores found or an error occurred."),
            ),
          );
        }
      },
    );
  }
}
