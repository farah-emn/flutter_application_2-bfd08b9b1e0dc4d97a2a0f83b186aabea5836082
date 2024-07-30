import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:traveling/cards/flight_details_card.dart';
import '../../../classes/flight_details_class.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import '../../shared/custom_widgets/custom_search_textfield.dart';

class FlightSearchView extends StatefulWidget {
  const FlightSearchView({super.key});
  @override
  State<FlightSearchView> createState() => _FlightSearchViewState();
}

class _FlightSearchViewState extends State<FlightSearchView> {
  bool? isChecked = false;
  String? sorteBy;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _showBottomShest() {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (builder) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 190, 190, 190),
                          borderRadius: BorderRadius.circular(20)),
                      width: 50,
                      height: 5,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'From',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 45,
                            width: size.width - 50,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              decoration: textFielDecoratiom.copyWith(
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                      Icons.flight_takeoff_outlined)),
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'To',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 45,
                            width: size.width - 50,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              decoration: textFielDecoratiom.copyWith(
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                      Icons.flight_takeoff_outlined)),
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Stops',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (bool? newValue) {
                                      setState(
                                        () {
                                          isChecked = newValue;
                                        },
                                      );
                                    },
                                  ),
                                  const Text('Direct Flight'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (bool? newValue) {
                                      setState(
                                        () {
                                          isChecked = newValue;
                                        },
                                      );
                                    },
                                  ),
                                  const Text('Direct Flight'),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            height: 1,
                            width: size.width - 30,
                            color: AppColors.gray,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Store by',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Lowest price',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        'Lowest price',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Shortest duration',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        'Shortest duration',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Earliest depature',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        'Earliest depature',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Latest duration',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        'Latest duration',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            height: 1,
                            width: size.width - 30,
                            color: AppColors.gray,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Store by',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Lowest price',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        'Lowest price',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Shortest duration',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        'Shortest duration',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: AppColors.mainColorBlue,
                                        value: 'Earliest depature',
                                        groupValue: sorteBy,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              sorteBy = value.toString();
                                            },
                                          );
                                        },
                                      ),
                                      const Text(
                                        'Earliest depature',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            height: 1,
                            width: size.width - 30,
                            color: AppColors.gray,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Price range',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grayText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      height: 50,
                      width: size.width - 30,
                      decoration: BoxDecoration(
                          color: AppColors.Blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Show 259 of 312 flights',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.StatusBarColor,
        body: SafeArea(
          child: Stack(children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Flights',
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
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 45,
                        width: size.width - 30,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: searchTextFielDecoratiom.copyWith(
                            hintText: "Search for flight",
                            suffixIcon: InkWell(
                              onTap: _showBottomShest,
                              child: const Icon(
                                Icons.filter_alt,
                                color: AppColors.LightGrayColor,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppColors.grayText,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: flightsDetails.length,
                          itemBuilder: (context, index) => FlightDetailsCard(
                            itemIndex: index,
                            flightModel: flightsDetails[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
