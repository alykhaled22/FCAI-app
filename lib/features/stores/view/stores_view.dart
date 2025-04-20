import 'package:fcai_app/features/stores/view/widgets/stores_list_view_builder.dart';
import 'package:fcai_app/features/stores/view/widgets/stores_view_header.dart';
import 'package:flutter/material.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          StoresViewHeader(title: "Stores",),
          Expanded(
            child: CustomScrollView(
              slivers: [
                StoresListViewBuilder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
