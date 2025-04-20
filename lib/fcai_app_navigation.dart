import 'package:fcai_app/features/stores/view/fav_stores_view.dart';
import 'package:fcai_app/features/stores/view/stores_view.dart';
import 'package:fcai_app/features/stores/viewmodel/stores_provider.dart';
import 'package:fcai_app/features/user_profile/view/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FcaiAppNavigation extends StatefulWidget {
  const FcaiAppNavigation({super.key});

  @override
  State<FcaiAppNavigation> createState() => _FcaiAppNavigationState();
}

class _FcaiAppNavigationState extends State<FcaiAppNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    StoresView(),
    FavStoresView(),
    // UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = StoresProvider();
        provider.init(); // تحميل المتاجر مرة واحدة
        return provider;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffFFFFFF),
          body: _screens[_currentIndex],
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  selectedItemColor: Color(0xff4F46E5),
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
      ),
    );
  }
}
