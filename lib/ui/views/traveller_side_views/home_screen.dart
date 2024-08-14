import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/hotel_bookings_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/views/traveller_side_views/bookings_view.dart';
import 'package:traveling/ui/views/traveller_side_views/home_view.dart';
import 'package:traveling/ui/views/traveller_side_views/profile_view.dart';
import 'package:traveling/ui/views/traveller_side_views/search_view.dart';

class Home extends StatefulWidget {
  final int initialIndex;

  Home({super.key, this.initialIndex = 0});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex;
  HotelBookingsController hotelBookingsController =
      Get.put(HotelBookingsController());
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    // Delay the state change to avoid calling setState during build
    // if (widget.NewBookingRoom == true) {
    //   Future.delayed(Duration(seconds: 5), () {
    //     setState(() {
    //       widget.NewBookingRoom = false;
    //     });
    //   });
    // }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const HomeView(),
      SearchView(),
      BookingsView(),
      const ProfileView(),
    ];

    // hotelBookingsController.Newbooking.value = true;
    // Future.delayed(Duration(seconds: 5), () {
    //   hotelBookingsController.Newbooking.value = false;
    // });
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          indicatorColor: AppColors.darkBlue,
          backgroundColor: Colors.white,
          shadowColor: AppColors.Blue,
        ),
        child: NavigationBar(
          elevation: 1,
          height: 60,
          selectedIndex: _selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          animationDuration: const Duration(seconds: 2),
          onDestinationSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
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
              icon: Icon(Icons.notifications),
              selectedIcon: Icon(
                Icons.notifications,
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
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
