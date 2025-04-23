import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem(
      {super.key, required this.label, required this.info, this.last = false});

  final String label;
  final String info;
  final bool? last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF6B7280),
                    fontFamily: "GT Sectra Fine" // رمادي هادي زي التصميم
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  info,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
            ],
          ),
          last == true ? const SizedBox.shrink() : const SizedBox(height: 15),
          last == true
              ? const SizedBox.shrink()
              : const Divider(
                  thickness: 0.5,
                  height: 0,
                  color: Color(0xFFCBD5E1), // لون divider خفيف وواضح
                ),
        ],
      ),
    );
  }
}
