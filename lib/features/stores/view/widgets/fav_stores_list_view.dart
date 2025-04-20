import 'package:fcai_app/features/stores/view/widgets/store_item.dart';
import 'package:fcai_app/features/stores/viewmodel/stores_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FavStoresListView extends StatelessWidget {
  const FavStoresListView({super.key});

  @override
  Widget build(BuildContext context) {
    final favStores = Provider.of<StoresProvider>(context).favStores;

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
