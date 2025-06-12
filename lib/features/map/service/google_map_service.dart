import 'package:fcai_app/features/map/view/widgets/modal_sheet_view.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapService {
  static Future<BitmapDescriptor> customIcon() async {
    return await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(48, 48)), "assets/images/restaurant.png");
  }

  static void showRestaurantInfo(
      RestaurantModel restaurantModel, BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ModalSheetView(restaurantModel: restaurantModel),
            ),
          );
        });
  }
}
