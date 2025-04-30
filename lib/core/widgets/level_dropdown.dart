import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LevelDropDown extends StatefulWidget {
  const LevelDropDown(
      {super.key, required this.onSelected, required this.initialLevel});

  final void Function(int?) onSelected;
  final int? initialLevel;

  @override
  State<LevelDropDown> createState() => _LevelDropDownState();
}

class _LevelDropDownState extends State<LevelDropDown> {
  late int? selectedValue;
  List<int> levels = [1, 2, 3, 4];

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialLevel; 
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<int>(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      label: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text('Level'),
      ),
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.secondaryColor),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(4),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
      ),
      width: MediaQuery.of(context).size.width - 80,
      initialSelection: selectedValue,
      onSelected: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onSelected(value); 
      },
      dropdownMenuEntries: levels.map((int level) {
        return DropdownMenuEntry<int>(
          value: level,
          label: level.toString(),
        );
      }).toList(),
    );
  }
}
