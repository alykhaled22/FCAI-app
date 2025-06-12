import 'dart:async';
import 'package:fcai_app/core/services/location_service.dart';
import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/features/map/service/google_map_service.dart';
import 'package:fcai_app/features/map/service/routes_api.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:fcai_app/features/restaurants/view/widgets/holder_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppMapView extends StatefulWidget {
  const AppMapView({
    super.key,
    required this.restaurantModel,
  });

  final RestaurantModel restaurantModel;

  @override
  State<AppMapView> createState() => _AppMapViewState();
}

class _AppMapViewState extends State<AppMapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String mapStyle = "";

  Set<Marker> marker = {};
  Set<Polyline> polyline = {};
  late Position? position;
  bool isLoading = false;
  bool failed = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    setState(() {});
    loadMapStyle();
    fetchUserLocationAndRoute();
  }

  Future<void> fetchUserLocationAndRoute() async {
    position = await LocationService.getCurrentLocation(context);
    if (position == null) {
      failed = true;
      isLoading = false;
      setState(() {});
      return;
    }

    final userLocation = LatLng(position!.latitude, position!.longitude);

    final restaurantLocation = LatLng(
      widget.restaurantModel.latitude,
      widget.restaurantModel.longitude,
    );

    try {
      final routePoints = await RoutesApi.getRouteFromORS(
        userLocation,
        restaurantLocation,
      );

      polyline.add(Polyline(
        polylineId: const PolylineId("route"),
        color: Colors.blue,
        width: 5,
        points: routePoints,
      ));
    } on Exception {
      isLoading = false;
      failed = true;
      setState(() {});
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : failed
                ? Center(
                    child: Center(
                      child: HolderBody(
                        icon: const Icon(Icons.map,
                            size: 36, color: AppColors.primaryColor),
                        title: "Could not get Directions",
                        message:
                            "Maybe there was a problem with your location, please reload the page to fetch nearby restaurants.",
                        buttonText: "Reload",
                        onPressed: () async {
                          isLoading = true;
                          failed = false;
                          setState(() {});
                          await fetchUserLocationAndRoute();
                        },
                      ),
                    ),
                  )
                : GoogleMap(
                    style: mapStyle,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        position!.latitude,
                        position!.longitude,
                      ),
                      zoom: 15,
                    ),
                    onMapCreated: (controller) async {
                      _controller.complete(controller);
                      marker.add(
                        Marker(
                          markerId: MarkerId("marker1"),
                          position: LatLng(
                            widget.restaurantModel.latitude,
                            widget.restaurantModel.longitude,
                          ),
                          icon: await GoogleMapService.customIcon(),
                          onTap: () {
                            GoogleMapService.showRestaurantInfo(
                                widget.restaurantModel, context);
                          },
                        ),
                      );
                      marker.add(
                        Marker(
                          markerId: MarkerId("marker2"),
                          position: LatLng(
                            position!.latitude,
                            position!.longitude,
                          ),
                        ),
                      );
                      setState(() {});
                    },
                    polylines: polyline,
                    markers: marker,
                  ),
      ),
    );
  }

  void loadMapStyle() async {
    final String style = await DefaultAssetBundle.of(context)
        .loadString("assets/map/map_style.json");
    setState(() {
      mapStyle = style;
    });
  }
}
