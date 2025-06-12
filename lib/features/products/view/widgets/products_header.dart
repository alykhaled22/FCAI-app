import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/features/map/view/app_map_view.dart';
import 'package:fcai_app/features/restaurants/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class ProductsHeader extends StatelessWidget {
  const ProductsHeader({
    super.key,
    required this.restaurantModel,
  });

  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        Image.network(
          restaurantModel.image,
          fit: BoxFit.cover,
          width: 50,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  restaurantModel.name,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GT Sectra Fine',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  restaurantModel.address,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppMapView(
                        restaurantModel: restaurantModel,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 45,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primaryColor,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Get Directions",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'GT Sectra Fine',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
