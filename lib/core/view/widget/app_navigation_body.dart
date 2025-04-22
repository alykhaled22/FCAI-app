import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/core/viewmodel/navigation_provider.dart';
import 'package:fcai_app/features/stores/view/fav_stores_view.dart';
import 'package:fcai_app/features/stores/view/stores_view.dart';
import 'package:fcai_app/features/user_profile/view/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppNavigationBody extends StatelessWidget {
  const AppNavigationBody({super.key});

  final List<Widget> screens = const [
    StoresView(),
    FavStoresView(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: screens[provider.currentIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.currentIndex,
                onTap: (index) {
                  provider.changeTab(index);
                },
                selectedItemColor: AppColors.primaryColor,
                backgroundColor: Color(0xFFF2F4F7),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.store),
                    label: 'Stores',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
