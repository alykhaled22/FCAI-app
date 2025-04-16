import 'package:dio/dio.dart';
import 'package:fcai_app/features/stores/model/nearby_places_model.dart';
import 'package:fcai_app/features/stores/services/nearby_places_api.dart';
import 'package:fcai_app/features/stores/view/widgets/stores_list_view.dart';
import 'package:flutter/material.dart';

class StoresListViewBuilder extends StatefulWidget {
  const StoresListViewBuilder({super.key});

  @override
  State<StoresListViewBuilder> createState() => _StoresListViewBuilderState();
}

class _StoresListViewBuilderState extends State<StoresListViewBuilder> {
  dynamic future;
  @override
  void initState() {
    super.initState();
    future = NearbyPlacesApi(dio: Dio()).fetchNearbyPlaces(0.0, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NearbyPlacesModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StoresListView(nearbyPlacesModel: snapshot.data??[],);
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text("Oops there was an Error, Please try again later :)"),
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
