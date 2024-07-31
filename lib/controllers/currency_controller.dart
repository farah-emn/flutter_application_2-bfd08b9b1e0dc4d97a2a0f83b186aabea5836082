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

  double convert(String from, String to, double amount) {
    Map<String, double> rates = {
      'AED': 3.67,
      'KWD': 0.30,
      'BHD': 0.38,
      'EUR': 0.85,
      'GBP': 0.75,
      'USD': 1.00,
      'INR': 74.25,
      'OMR': 0.39,
    };
    double amountInUsd = amount / rates[from]!;
    double convertedAmount = amountInUsd * rates[to]!;
    String resultAsString = convertedAmount.toStringAsFixed(2);
    double finalResult = double.parse(resultAsString);
    return finalResult;
  }
}
