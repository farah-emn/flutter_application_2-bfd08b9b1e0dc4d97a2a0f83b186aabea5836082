import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'flight_add_view.dart';
import 'flight_home_view.dart';
import 'flight_about_us_view.dart';
import 'flight_search_view.dart';

class FlightHome extends StatefulWidget {
  const FlightHome({super.key});

  @override
  State<FlightHome> createState() => _FlightHomeState();
}

class _FlightHomeState extends State<FlightHome> {
  int index = 0;
  final Screens = [
    const FlightHomeView(),
    const FlightSearchView(),
    const FlightAddView(),
    const FlightAboutUsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
            indicatorColor: AppColors.darkBlue,
            indicatorShape: CircleBorder(),
            backgroundColor: Colors.white),
        child: NavigationBar(
            elevation: 1,
            height: 60,
            selectedIndex: index,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            animationDuration: const Duration(seconds: 2),
            onDestinationSelected: (index) => setState(() {
                  this.index = index;
                }),
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: AppColors.BlueText,
                ),
                selectedIcon: Icon(
                  Icons.home_filled,
                  color: AppColors.backgroundgrayColor,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.search_outlined,
                  color: AppColors.BlueText,
                ),
                selectedIcon: Icon(
                  Icons.search_outlined,
                  color: AppColors.backgroundgrayColor,
                ),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.add_outlined,
                  color: AppColors.BlueText,
                ),
                selectedIcon: Icon(
                  Icons.add,
                  color: AppColors.backgroundgrayColor,
                ),
                label: 'add',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.business_outlined,
                  color: AppColors.BlueText,
                ),
                selectedIcon: Icon(
                  Icons.business,
                  color: AppColors.backgroundgrayColor,
                ),
                label: 'About Us',
              ),
            ]),
      ),
    );
  }
}
