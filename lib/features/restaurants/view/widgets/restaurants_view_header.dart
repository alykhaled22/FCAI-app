import 'package:fcai_app/core/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class RestaurantsViewHeader extends StatelessWidget {
  const RestaurantsViewHeader({super.key, required this.title, this.onChanged});
  final String title;
  final void Function(String)? onChanged;

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
        CustomSearchBar(
          onChanged: onChanged,
          hintText: 'Search restaurants or items...',
        ),
        SizedBox(height: 25),
      ],
    );
  }
}
