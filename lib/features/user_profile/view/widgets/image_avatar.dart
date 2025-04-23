import 'dart:io';
import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({super.key, required this.gender, this.image});
  final String gender;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = image != null && image != "";

    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color:Colors.grey.shade400, width: 5), //
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipOval(
        child: hasImage
            ? Image.file(File(image!), fit: BoxFit.cover)
            : Image.asset(
                gender == "Female"
                    ? 'assets/female_placeholder.png'
                    : 'assets/male-placeholder.jpg',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
