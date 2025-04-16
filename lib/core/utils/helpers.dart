import 'package:flutter/material.dart';

class Helpers {
  static String getCategoryImage(String category) {
    category = category.toLowerCase();

    if (category.contains('market')) {
      return 'assets/market.png';
    } else if (category.contains('restaurant')) {
      return 'assets/resturant.png';
    } else {
      return 'assets/store.png';
    }
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
