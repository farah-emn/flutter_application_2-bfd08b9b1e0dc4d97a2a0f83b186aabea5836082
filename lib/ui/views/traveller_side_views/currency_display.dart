// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/currency_controller.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/utils.dart';

class CurrencyDisplay extends StatelessWidget {
  const CurrencyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CurrencyController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.StatusBarColor,
        body: SafeArea(
            child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const Text(
                  'Currency display',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.backgroundgrayColor),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.save_as,
                    color: AppColors.backgroundgrayColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/png/background1.png'),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 40, end: 40, top: 20),
            child: InkWell(
              onTap: () {
                Get.to(CurrencyPage());
              },
              child: Row(children: [
                const SizedBox(
                  height: 200,
                ),
                Text(
                  'Currency display',
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.grayText,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                const Image(
                  image: AssetImage('assets/image/png/arrow icon.png'),
                ),
              ]),
            ),
          )
        ])));
  }
}

class CurrencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CurrencyController controller = Get.find();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(
                  width: 160,
                ),
                const Text('Profile',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
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
                              color: Colors.blue,
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
      ),
    );
  }
}
