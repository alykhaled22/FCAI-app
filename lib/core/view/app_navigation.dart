import 'package:fcai_app/core/view/widget/app_navigation_body.dart';
import 'package:fcai_app/core/viewmodel/navigation_provider.dart';

import 'package:fcai_app/features/stores/viewmodel/stores_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key,  this.initialPage = 0});
  final int initialPage ;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => StoresProvider()..init(context),
        ),
      ],
      child: AppNavigationBody(initialPage: initialPage,),
    );
  }
}
