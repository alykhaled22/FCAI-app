import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({super.key, required this.gender});
  final String gender;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 90,
      backgroundImage: gender == "Female"
          ? AssetImage('assets/female_placeholder.png')
          : AssetImage('assets/male-placeholder.jpg'),
    );
  }
}
