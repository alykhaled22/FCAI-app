import 'package:fcai_app/features/stores/model/nearby_places_model.dart';
import 'package:fcai_app/features/stores/view/widgets/store_item.dart';
import 'package:flutter/material.dart';

class StoresListView extends StatelessWidget {
  const StoresListView({super.key, required this.nearbyPlacesModel});
  final List<NearbyPlacesModel> nearbyPlacesModel;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: nearbyPlacesModel.length, (context, index) {
      return StoreItem(
        nearbyPlacesModel: nearbyPlacesModel[index],
      );
    }));
  }
}
