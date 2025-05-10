import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:fcai_app/features/restaurants/viewmodel/resturants_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantsItem extends StatelessWidget {
  const RestaurantsItem({super.key, required this.restaurantModel});

  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
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
              IconButton(
                icon: Icon(
                  restaurantModel.isFav
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 30,
                ),
                color: restaurantModel.isFav ? Colors.red : Colors.grey,
                onPressed: () {
                  Provider.of<RestaurantsProvider>(context, listen: false)
                      .toggleFav(restaurantModel);
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
