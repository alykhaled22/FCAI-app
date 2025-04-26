import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SearchStoresBar extends StatelessWidget {
  const SearchStoresBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search stores...',
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          onChanged: (value) {},
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ));
  }
}
