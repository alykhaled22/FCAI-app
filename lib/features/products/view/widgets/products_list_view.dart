import 'package:fcai_app/features/products/model/product_model.dart';
import 'package:fcai_app/features/products/view/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: products.length,
            (context, index) {
      return ProductItem(
        productModel: products[index],
      );
    }));
  }
}
