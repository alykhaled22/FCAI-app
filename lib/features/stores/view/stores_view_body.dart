import 'package:fcai_app/features/stores/view/widgets/search_bar.dart';
import 'package:fcai_app/features/stores/view/widgets/stores_list_view_builder.dart';
import 'package:flutter/material.dart';

class StoresViewBody extends StatelessWidget {
  const StoresViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10),
            SearchStoresBar(),
            SizedBox(height: 20),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  StoresListViewBuilder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
