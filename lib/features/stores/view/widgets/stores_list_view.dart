import 'package:fcai_app/features/stores/model/store_model.dart';
import 'package:fcai_app/features/stores/view/widgets/store_item.dart';
import 'package:flutter/material.dart';

class StoresListView extends StatelessWidget {
  const StoresListView({super.key, required this.nearbyStoresModel});
  final List<StoreModel> nearbyStoresModel;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: nearbyStoresModel.length, (context, index) {
      return StoreItem(
        nearbyPlacesModel: nearbyStoresModel[index],
      );
    }));
  }
}
