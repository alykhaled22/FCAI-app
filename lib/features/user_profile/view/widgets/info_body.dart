import 'package:fcai_app/core/models/user_model.dart';
import 'package:fcai_app/features/user_profile/view/widgets/card_item.dart';
import 'package:flutter/material.dart';

class InfoBody extends StatelessWidget {
  const InfoBody({super.key, required this.userModel});

  final UserModel userModel;

  static const levels = {
    "1": "Freshman",
    "2": "Sophomore",
    "3": "Junior",
    "4": "Senior",
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      color: const Color.fromARGB(255, 247, 248, 253),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "GT Sectra Fine"
              ),
            ),
            const SizedBox(height: 20),
            CardItem(
              label: "ID",
              info: userModel.id.toString(),
            ),
            const SizedBox(height: 10),
            CardItem(
              label: "Email",
              info: userModel.email,
            ),
            const SizedBox(height: 10),
            CardItem(
              label: "Gender",
              info: userModel.gender ?? "Unknown",
            ),
            const SizedBox(height: 10),
            CardItem(
              label: "level",
              info: userModel.level != null
                  ? "${userModel.level} (${levels[userModel.level]})"
                  : "Unknown",
              last: true,
            ),
          ],
        ),
      ),
    );
  }
}
