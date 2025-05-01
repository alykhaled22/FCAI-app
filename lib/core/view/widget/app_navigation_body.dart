import 'package:fcai_app/core/utils/app_colors.dart';
import 'package:fcai_app/core/viewmodel/navigation_provider.dart';
import 'package:fcai_app/features/authentication/viewmodel/user_provider.dart';
import 'package:fcai_app/features/stores/view/fav_stores_view.dart';
import 'package:fcai_app/features/stores/view/stores_view.dart';
import 'package:fcai_app/features/user_profile/view/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppNavigationBody extends StatefulWidget {
  final int initialPage;
  const AppNavigationBody({super.key, this.initialPage = 0});

  @override
  State<AppNavigationBody> createState() => _AppNavigationBodyState();
}

class _AppNavigationBodyState extends State<AppNavigationBody> {
  late PageController _pageController;

  final List<Widget> screens = const [
    StoresView(),
    FavStoresView(),
    UserProfile(),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: widget.initialPage);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NavigationProvider>(context, listen: false)
          .updateIndex(widget.initialPage);
      Provider.of<UserProvider>(context, listen: false)
          .loadCurrentUser(context);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    provider.pageController = _pageController;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            provider.updateIndex(index);
          },
          children: screens,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              bottom: 12.0, left: 16.0, right: 16.0, top: 8.0),
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
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                selectedItemColor: AppColors.primaryColor,
                backgroundColor: AppColors.secondaryColor,
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
