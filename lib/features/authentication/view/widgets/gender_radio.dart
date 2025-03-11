import 'package:flutter/material.dart';

class GenderRadio extends StatefulWidget {
  const GenderRadio({super.key});

  @override
  State<GenderRadio> createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  String? selectedGender; // Variable to store selected value

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

  Widget _buildGenderButton(String gender) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        side: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Row(
        children: [
          Text(
            gender,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(width: 5),
          Radio<String>(
            value: gender,
            groupValue: selectedGender,
            toggleable: true,
            onChanged: (value) {
              setState(() {
                selectedGender = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
