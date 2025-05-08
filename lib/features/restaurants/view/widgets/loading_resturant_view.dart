import 'package:fcai_app/features/restaurants/view/widgets/fake_restaurant_item.dart';
import 'package:flutter/material.dart';

class LoadingResturantsView extends StatelessWidget {
  const LoadingResturantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: 10, (context, index) {
      return FakeRestaurantsItem();
    }));
  }
}
