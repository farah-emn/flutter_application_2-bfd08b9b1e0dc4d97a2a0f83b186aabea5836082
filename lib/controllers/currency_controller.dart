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
    'CAD',
    'AUD'
  ];
  List<String> currencySymbols = [
    'DH',
    'DIN',
    'BD',
    '\$',
    '€',
    '£',
    '₹',
    '\$',
    '\$'
  ];

  List<String> currencyText = [
    'United Arab Emirates Dirham',
    'Kuwaiti Dinar',
    'Bahraini Dinar',
    'US Dollar',
    'Euro',
    'British Pound Sterling',
    'Indian Rupee',
    'Canadian Dollar',
    'Australian Dollar'
  ];

  RxString selectedCurrency = 'USD'.obs;

  void updateCurrency(String newCurrency) {
    selectedCurrency.value = newCurrency;
  }

  double convert(String to, double amount) {
    Map<String, double> rates = {
      'AED': 3.67,
      'KWD': 0.30,
      'BHD': 0.38,
      'EUR': 0.85,
      'GBP': 0.75,
      'USD': 1.00,
      'INR': 74.25,
      'CAD': 0.77,
      'AUD': 0.65
    };
    double amountInUsd = amount / rates['USD']!;
    double convertedAmount = amountInUsd * rates[to]!;
    String resultAsString = convertedAmount.toStringAsFixed(2);
    double finalResult = double.parse(resultAsString);
    return finalResult;
  }

  String getCurrencySymbol(String currencyCode) {
    int index = currencyCodes.indexOf(currencyCode);
    if (index == -1) {
      return 'Unknown';
    }
    return currencySymbols[index];
  }
}
