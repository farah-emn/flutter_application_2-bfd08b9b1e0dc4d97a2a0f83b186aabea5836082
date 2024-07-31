import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/views/traveller_side_views/bookings_view.dart';
import 'package:traveling/ui/views/traveller_side_views/home_view.dart';
import 'package:traveling/ui/views/traveller_side_views/profile_view.dart';
import 'package:traveling/ui/views/traveller_side_views/search_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  final Screens = [
    const HomeView(),
    const SearchView(),
    const BookingsView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          indicatorColor: AppColors.darkBlue,
          backgroundColor: Colors.white,
          indicatorShape: CircleBorder()

        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          height: 60,

          selectedIndex: index,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          animationDuration: const Duration(seconds: 2),
          onDestinationSelected: (index) => setState(
            () {
              this.index = index;
            },
          ),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(
                Icons.home_filled,
                color: AppColors.backgroundgrayColor,
              ),
              label: 'Home',

            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(
                Icons.search_outlined,
                color: AppColors.backgroundgrayColor,
              ),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_outlined),
              selectedIcon: Icon(
                Icons.bookmark_outlined,
                color: AppColors.backgroundgrayColor,
              ),
              label: 'Bookings',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_2_rounded),
              selectedIcon: Icon(
                Icons.person_2_rounded,
                color: AppColors.backgroundgrayColor,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
