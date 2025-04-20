import 'package:fcai_app/features/stores/view/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class StoresViewHeader extends StatelessWidget {
  const StoresViewHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'GT Sectra Fine',
            ),
          ),
        ),
        SizedBox(height: 15),
        SearchStoresBar(),
        SizedBox(height: 25),
      ],
    );
  }
}
