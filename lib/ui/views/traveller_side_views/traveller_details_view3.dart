import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/traveller_side_views/traveller_details_view2.dart';

import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';

class TravellerDetailsView3 extends StatefulWidget {
  const TravellerDetailsView3({super.key});
  @override
  State<TravellerDetailsView3> createState() => _TravellerDetailsView3State();
}

class _TravellerDetailsView3State extends State<TravellerDetailsView3> {
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
                    'Travellers',
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
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.supervised_user_circle_rounded,
                    size: 100,
                    color: AppColors.gold,
                  ),
                  const Text(
                    'Your regular travellers',
                    style: TextStyle(
                        fontSize: TextSize.header1,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Save your regular travellers details to make bookings quick and easy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: TextSize.header2,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () => {Get.off(() => TravellerDetailsView2())},
                    child: CustomButton(
                        text: 'Add Traveller',
                        textColor: Colors.white,
                        widthPercent: size.width,
                        backgroundColor: AppColors.darkBlue),
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
