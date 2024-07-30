import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';

class FlightSummeryView extends StatelessWidget {
  const FlightSummeryView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Column(
        children: [
          Container(
            width: size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/image/png/flynas.png'),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Flynas',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          '22. Des, 2023',
                          style: TextStyle(color: AppColors.TextgrayColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '09:30',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(
                              'AM',
                              style: TextStyle(
                                color: AppColors.TextgrayColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Direct',
                          style: TextStyle(
                            color: AppColors.TextgrayColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '02h 25m',
                          style: TextStyle(
                            color: AppColors.TextgrayColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              '01:05',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(
                              'PM',
                              style: TextStyle(
                                color: AppColors.TextgrayColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      color: const Color.fromARGB(255, 206, 206, 206),
                      width: 1,
                      height: 130,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width / 2 + 30,
                          child: const Text(
                            'Cairo International Airport',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ),
                        const Text(
                          'Cairo, Eygpt',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: AppColors.TextgrayColor),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: size.width / 2 + 30,
                          child: Text(
                            'King Khaled International Airport',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ),
                        Text(
                          'Riyadh, Saudi Arabia',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: AppColors.TextgrayColor),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/image/png/Wifi_icon.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Wifi is available'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/image/png/Wifi_icon.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('in seat power & USB outlets'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/image/png/Wifi_icon.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('in seat power & USB outlets'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Baggage allowance',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/image/png/Wifi_icon.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Wifi is available'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/image/png/Wifi_icon.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('in seat power & USB outlets'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/image/png/Wifi_icon.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('in seat power & USB outlets'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
