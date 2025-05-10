import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/features/products/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 132,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: 120,
                  height: 120,
                  fit: BoxFit.fill,
                  imageUrl: productModel.image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 7),
                    Text(
                      productModel.name,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff363A33),
                          fontFamily: 'Poppins'),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      maxLines: 2,
                      "210 grams burger patty stuffed with cheese, beef bacon, mozzarella sticks, BBQ sauce, big tasty sauce, cheddar, lettuce, tomatoes and potatoes",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 11,
                        color: Color(0xff60655C),
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EGP ${productModel.price}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: Color(0xff363A33),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xffF2F2F2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              size: 20,
                              Icons.add,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
