import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class ModalSheetView extends StatelessWidget {
  const ModalSheetView({super.key, required this.restaurantModel});
  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                imageUrl: restaurantModel.image,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantModel.name,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "GT Sectra Fine"),
                  ),
                  SizedBox(height: 3),
                  Text(
                    restaurantModel.category,
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
                    restaurantModel.address,
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
                        "${(restaurantModel.distance).toStringAsFixed(2)} km",
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
          ],
        )
      ],
    );
  }
}
