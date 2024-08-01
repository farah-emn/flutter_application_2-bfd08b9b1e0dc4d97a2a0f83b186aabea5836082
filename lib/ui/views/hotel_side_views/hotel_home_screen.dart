import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'hotel_add_view.dart';
import 'hotel_home_view.dart';
import 'hotel_about_us_view.dart';
import 'hotel_search_view.dart';

class HoteltHome extends StatefulWidget {
  const HoteltHome({super.key});

  @override
  State<HoteltHome> createState() => _HoteltHomeState();
}

class _HoteltHomeState extends State<HoteltHome> {
  int index = 0;
  final Screens = [
    const HotelHomeView(),
    const HotelSearchView(),
    const HotelAddView(),
    const HotelAboutUsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
            indicatorColor: AppColors.gray, backgroundColor: Colors.white),
        child: NavigationBar(
            elevation: 1,
            height: 60,
            selectedIndex: index,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            animationDuration: const Duration(seconds: 2),
            onDestinationSelected: (index) => setState(() {
                  this.index = index;
                }),
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  size: 25,
                  Icons.home_rounded,
                  color: AppColors.grayText,
                ),
                selectedIcon: Icon(
                  size: 25,
                  Icons.home_rounded,
                  color: AppColors.purple,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  size: 25,
                  Icons.search_outlined,
                  color: AppColors.grayText,
                ),
                selectedIcon: Icon(
                  size: 25,
                  Icons.search_outlined,
                  color: AppColors.purple,
                ),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(
                  size: 25,
                  Icons.add_outlined,
                  color: AppColors.grayText,
                ),
                selectedIcon: Icon(
                  size: 25,
                  Icons.add,
                  color: AppColors.purple,
                ),
                label: 'add',
              ),
              NavigationDestination(
                icon: Icon(
                  size: 25,
                  Icons.people_rounded,
                  color: AppColors.grayText,
                ),
                selectedIcon: Icon(
                  size: 25,
                  Icons.people_rounded,
                  color: AppColors.purple,
                ),
                label: 'About Us',
              ),
            ]),
      ),
    );
  }
}
