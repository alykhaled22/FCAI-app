import 'package:fcai_app/features/stores/view/widgets/custom_app_bar.dart';
import 'package:fcai_app/features/stores/view/widgets/search_bar.dart';
import 'package:fcai_app/features/stores/view/widgets/stores_list_view_builder.dart';
import 'package:flutter/material.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              CustomAppBar(),
              SizedBox(height: 10),
              SearchStoresBar(),
              SizedBox(height: 20),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    StoresListViewBuilder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
