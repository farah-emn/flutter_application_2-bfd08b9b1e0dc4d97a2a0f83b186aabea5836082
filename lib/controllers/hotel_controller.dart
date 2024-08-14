import 'package:get/get.dart';
import 'package:traveling/classes/hotel1.dart';

class HotelController extends GetxController {
  var hotels = <HotelClass1>[].obs;
  var selectedIndex = 0.obs;

  void setHotels(List<HotelClass1> hotelList) {
    hotels.value = hotelList;
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  HotelClass1 get selectedHotel => hotels[selectedIndex.value];
}
