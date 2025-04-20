import 'package:fcai_app/features/stores/view/widgets/fav_stores_list_view.dart';
import 'package:fcai_app/features/stores/view/widgets/search_bar.dart';
import 'package:fcai_app/features/stores/view/widgets/stores_view_header.dart';
import 'package:flutter/material.dart';

class FavStoresView extends StatelessWidget {
  const FavStoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
         StoresViewHeader(title: "Favorite Stores",),
          Expanded(
            child: CustomScrollView(
              slivers: [
                FavStoresListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
