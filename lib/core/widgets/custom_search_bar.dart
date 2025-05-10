import 'package:flutter/material.dart';
import 'package:fcai_app/core/utils/app_colors.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final void Function(String)? onChanged;

  const CustomSearchBar({super.key, required this.hintText, this.onChanged});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: _isFocused ? AppColors.primaryColor : Colors.grey[300]!,
          width: 1.5,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppColors.primaryColor.withAlpha((0.2 * 255).toInt()),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isFocused
                ? const Icon(Icons.search,
                    color: AppColors.primaryColor, key: ValueKey('focused'))
                : const Icon(Icons.search,
                    color: Colors.grey, key: ValueKey('unfocused')),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: widget.onChanged,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
