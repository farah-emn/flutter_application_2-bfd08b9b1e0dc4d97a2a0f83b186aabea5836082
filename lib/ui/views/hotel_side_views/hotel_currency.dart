// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/ui/shared/colors.dart';

class HotelCurrencyDisplay extends StatelessWidget {
  const HotelCurrencyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrencyController controller = Get.find();
    Get.put(CurrencyController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.lightPurple,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.backgroundgrayColor,
                  ),
                ),
                SizedBox(
                  width: size.width / 2 - 75,
                ),
                const Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.backgroundgrayColor),
                ),
                // InkWell(
                //   onTap: () {},
                //   child: const Icon(
                //     Icons.save_as,
                //     color: AppColors.backgroundgrayColor,
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 70,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/png/background1.png'),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(CurrencyPage());
            },
            child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.currencyCodes.length,
                itemBuilder: (context, index) {
                  String key = controller.currencyCodes[index];
                  return Obx(() {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            key,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            controller.currencyText[index],
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      trailing: controller.selectedCurrency.value == key
                          ? Icon(
                              Icons.check,
                              color: Colors.purple,
                            )
                          : null,
                      onTap: () {
                        controller.updateCurrency(key);
                        Get.back();
                      },
                    );
                  });
                },
              ),
            ),
          ],
                    ),
          )
        ]));
  }
}

class CurrencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CurrencyController controller = Get.find();

    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.purple,
                ),
              ),
           
              Icon(
                Icons.arrow_back,
                color: AppColors.lightPurple,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
            ),
            child: Container(
              // width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/png/background1.png'),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
