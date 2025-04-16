import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Stores",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_outlined,
            size: 30,
          ),
          color: Colors.black,
        ),
      ],
    );
  }
}
