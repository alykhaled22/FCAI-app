import 'package:flutter/material.dart';

class GenderRadio extends StatelessWidget {
  const GenderRadio({super.key, required this.onChanged, required this.gender});

  final void Function(String?) onChanged;
  final String? gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildGenderButton("Male"),
            const SizedBox(width: 10),
            _buildGenderButton("Female"),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderButton(String genderValue) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        side: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        onChanged(genderValue);
      },
      child: Row(
        children: [
          Text(
            genderValue,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(width: 5),
          Radio<String>(
            value: genderValue,
            groupValue: gender,
            toggleable: true,
            onChanged: (value) {
              onChanged(value); // Notify parent of change
            },
          ),
        ],
      ),
    );
  }
}
