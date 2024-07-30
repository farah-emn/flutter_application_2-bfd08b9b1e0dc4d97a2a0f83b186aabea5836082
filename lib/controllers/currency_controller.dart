import 'package:get/get.dart';

class CurrencyController extends GetxController {
  static CurrencyController get to => Get.find();

  List<String> currencyCodes = [
    'AED',
    'KWD',
    'BHD',
    'USD',
    'EUR',
    'GBP',
    'INR',
    'OMR'
  ];
  List<String> currencyText = [
    'United Arab Emirates Dirham',
    'Kuwaiti Dinar',
    'Bahraini Dinar',
    'US Dollar',
    'Euro',
    'British Pound Sterling',
    'Indian Rupee',
    'Omani Rial'
  ];

  RxString selectedCurrency = 'USD'.obs;

  void updateCurrency(String newCurrency) {
    selectedCurrency.value = newCurrency;
  }
}
