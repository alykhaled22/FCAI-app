import 'package:flutter/material.dart';

class ProductsHeader extends StatelessWidget {
  const ProductsHeader(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.address});
  final String title;
  final String imageUrl;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: 50,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
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
                  address,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Montserrat',
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
