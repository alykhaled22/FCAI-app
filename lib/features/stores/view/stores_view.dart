import 'package:fcai_app/core/utils/helpers.dart';
import 'package:fcai_app/features/stores/view/widgets/stores_list_view_builder.dart';
import 'package:fcai_app/features/stores/view/widgets/stores_view_header.dart';
import 'package:fcai_app/features/stores/viewmodel/stores_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          StoresViewHeader(
            title: "Stores",
          ),
          Expanded(
            child: RefreshIndicator(
              backgroundColor: Colors.white,
              onRefresh: () async {
                return await Future.delayed(
                  Duration(seconds: 1),
                  () async {
                    if (!context.mounted) return;
                    await Provider.of<StoresProvider>(context, listen: false)
                        .fetchAndCacheStores(context);
                    if (!context.mounted) return;
                    Helpers.checkInternetConnection(context);
                  },
                );
              },
              child: CustomScrollView(
                slivers: [
                  StoresListViewBuilder(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
