import 'dart:io';

import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({super.key, required this.gender, this.image});
  final String gender;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 90,
      backgroundImage: (image != null && image != "")
          ? FileImage(File(image!))
          : gender == "Female"
              ? AssetImage('assets/female_placeholder.png')
              : AssetImage('assets/male-placeholder.jpg'),
    );
  }
}
