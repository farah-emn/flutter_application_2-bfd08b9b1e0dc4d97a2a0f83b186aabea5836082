import 'package:flutter/material.dart';
import 'package:traveling/cards/travellar_datails_card1.dart';
import 'package:traveling/classes/travellars_class1.dart';

import '../../shared/colors.dart';

class HotelBookingDetails extends StatefulWidget {
  const HotelBookingDetails({super.key});
  @override
  State<HotelBookingDetails> createState() => _HotelBookingDetailsState();
}

class _HotelBookingDetailsState extends State<HotelBookingDetails> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.StatusBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Booking details',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundgrayColor),
                  ),
                  SizedBox(),
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.man,
                                      color: AppColors.darkBlue,
                                    ),
                                    Text(
                                      'Adults:',
                                      style: TextStyle(
                                          color: AppColors.TextBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '5',
                                      style: TextStyle(
                                        color: AppColors.TextBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.boy,
                                      color: AppColors.darkBlue,
                                    ),
                                    Text(
                                      'Children:',
                                      style: TextStyle(
                                          color: AppColors.TextBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '3',
                                      style: TextStyle(
                                        color: AppColors.TextBlackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: AppColors.darkBlue,
                                ),
                                Text(
                                  'Total price:',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '5000',
                                  style: TextStyle(
                                    color: AppColors.TextBlackColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'User details',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                        'assets/image/png/girlUser1.png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'farah',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: AppColors.darkBlue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Email:',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'FarahEmad@gmail.com',
                                  style: TextStyle(
                                    color: AppColors.BlueText,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: AppColors.darkBlue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Mobile:',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '0996896662',
                                  style: TextStyle(
                                    color: AppColors.BlueText,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: AppColors.darkBlue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Nationality:',
                                  style: TextStyle(
                                      color: AppColors.TextBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Syria',
                                  style: TextStyle(
                                    color: AppColors.TextBlackColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Travellars',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: travellarsDetails.length,
                          itemBuilder: (context, index) =>
                              TravellarDetailsCard1(
                            itemIndex: index,
                            travellarsModel: travellarsDetails[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
