import 'package:flutter/material.dart';

class LoadingHolder extends StatelessWidget {
  const LoadingHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ),
    );
  }
}
