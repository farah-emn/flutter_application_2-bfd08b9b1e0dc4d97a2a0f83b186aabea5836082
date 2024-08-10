import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/shared/custom_widgets/custom_textfield2.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_details_view3.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';

class TravellerDetailsView2 extends StatefulWidget {
  const TravellerDetailsView2({super.key});
  @override
  State<TravellerDetailsView2> createState() => _TravellerDetailsView2State();
}

class _TravellerDetailsView2State extends State<TravellerDetailsView2> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightBlue,
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Text(
                    'Traveller Details',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_back,
                    color: AppColors.darkBlue,
                  ),
                ],
              ),
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
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 15, right: 15),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'First Name',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          onChanged: (value) {},
                          decoration: textFielDecoratiom.copyWith(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Midle Name',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          onChanged: (value) {},
                          decoration: textFielDecoratiom.copyWith(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Last Name',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          onChanged: (value) {},
                          decoration: textFielDecoratiom.copyWith(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Date of Birth',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          onChanged: (value) {},
                          decoration: textFielDecoratiom.copyWith(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Nationality',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          onChanged: (value) {},
                          decoration: textFielDecoratiom.copyWith(),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Traveller Document',
                            style: TextStyle(
                                fontSize: TextSize.header1,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Passport Number',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          onChanged: (value) {},
                          decoration: textFielDecoratiom.copyWith(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Issuing Country',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          onChanged: (value) {},
                          decoration: textFielDecoratiom.copyWith(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Expiry Date',
                            style: TextStyle(
                                fontSize: TextSize.header2,
                                color: AppColors.grayText,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          onChanged: (value) {},
                          decoration: textFielDecoratiom.copyWith(),
                        ),
                      ),
                      const SizedBox(
                        height: 90,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => {Get.off(() => const TravellerDetailsView3())},
                    child: CustomButton(
                        text: 'Save',
                        textColor: Colors.white,
                        widthPercent: size.width,
                        backgroundColor: AppColors.darkBlue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
