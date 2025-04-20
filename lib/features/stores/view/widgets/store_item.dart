import 'package:fcai_app/core/utils/helpers.dart';
import 'package:fcai_app/features/stores/model/store_model.dart';
import 'package:fcai_app/features/stores/viewmodel/stores_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreItem extends StatelessWidget {
  const StoreItem({super.key, required this.nearbyPlacesModel});

  final StoreModel nearbyPlacesModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                  Helpers.getCategoryImage(nearbyPlacesModel.category),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover),
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nearbyPlacesModel.name,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "GT Sectra Fine"),
                    ),
                    SizedBox(height: 3),
                    Text(
                      nearbyPlacesModel.category,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      nearbyPlacesModel.address,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${(nearbyPlacesModel.distance / 1000).toStringAsFixed(2)} km",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  nearbyPlacesModel.isFav
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 30,
                ),
                color:
                    nearbyPlacesModel.isFav ? Colors.red : Colors.grey,
                onPressed: () {
                   Provider.of<StoresProvider>(context, listen: false)
                      .toggleFav(nearbyPlacesModel);

                },
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
            thickness: 0.2,
          ),
        ],
      ),
    );
  }
}
