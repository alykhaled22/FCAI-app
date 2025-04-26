import 'package:fcai_app/features/stores/view/widgets/fake_store_item.dart';
import 'package:flutter/material.dart';

class LoadingStoresView extends StatelessWidget {
  const LoadingStoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: 10, (context, index) {
      return FakeStoreItem();
    }));
  }
}
