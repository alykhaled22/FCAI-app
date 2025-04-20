import 'package:fcai_app/features/stores/view/stores_view_body.dart';
import 'package:fcai_app/features/stores/viewmodel/stores_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: ChangeNotifierProvider(
        create: (context) {
          final provider = StoresProvider();
          provider.init();
          return provider;
        },
        child: StoresViewBody(),
      ),
    );
  }
}
