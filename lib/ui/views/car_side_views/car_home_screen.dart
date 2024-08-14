import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/views/car_side_views/car_about_us_view.dart';
import 'package:traveling/ui/views/car_side_views/car_home_view.dart';
import 'car_add_view.dart';
import 'car_search_view.dart';

class CarHome extends StatefulWidget {
  const CarHome({super.key});

  @override
  State<CarHome> createState() => _CarHomeState();
}

class _CarHomeState extends State<CarHome> {
  int index = 0;
  final Screens = [
    const CarHomeView(),
    const CarSearchView(),
    const CarAddView(),
    const CarAboutUsView(),
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
                  color: AppColors.darkGray,
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
                  color: AppColors.darkGray,
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
                  color: AppColors.darkGray,
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
                  color: AppColors.darkGray,
                ),
                label: 'About Us',
              ),
            ]),
      ),
    );
  }
}
