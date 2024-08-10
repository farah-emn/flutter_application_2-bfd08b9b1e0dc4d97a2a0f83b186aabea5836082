// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, avoid_print, use_key_in_widget_constructors, body_might_complete_normally_nullable, must_be_immutable, non_constant_identifier_names, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traveling/controllers/traveller_details_view1_controller.dart';
import 'package:traveling/controllers/flight_info_controller.dart';
import 'package:traveling/ui/shared/colors.dart';

class TravellerBaggage extends StatefulWidget {
  BaggageOption? initialSelectedOption;
  int? index;
  BaggageOption? Extrabaggage;
  TravellerBaggage({this.index, this.Extrabaggage});
  @override
  State<TravellerBaggage> createState() => _TravellerBaggageState();
}

class _TravellerBaggageState extends State<TravellerBaggage> {
  final FlightInfoController controller_flight =
      Get.find<FlightInfoController>();

  BaggageOption? selectedOption;
  late String deparure_from = controller_flight.flightInfo.value.deparure_from;
  late String arrival_to = controller_flight.flightInfo.value.arrival_to;
  var result;
  @override
  void initState() {
    super.initState();
  }

  void updateSelectedOption(BaggageOption? option) {
    setState(() {
      selectedOption = option;
    });
  }

  Future<BaggageOption?> showBaggageOptions() async {
    selectedOption = widget.Extrabaggage;

    result = await showModalBottomSheet<BaggageOption>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.2,
                maxChildSize: 0.8,
                builder: (_, controller) {
                  return Container(
                    // height: MediaQuery.of(context).size.height *
                    //     0.2, // This is 50% of the screen height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.5),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          key: UniqueKey(), // Add this line

                          title: Text('15 KG'),
                          subtitle: Text('Max 1 piece'),
                          trailing: Text('SAR 100'),
                          leading: Radio<BaggageOption>(
                            value: BaggageOption.option15kg,
                            groupValue: selectedOption,
                            onChanged: (BaggageOption? value) {
                              setState(() {
                                selectedOption = value;
                              });
                              Navigator.pop(context, selectedOption);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('20 KG'),
                          subtitle: Text('Max 1 piece'),
                          trailing: Text('SAR 150'),
                          leading: Radio<BaggageOption>(
                            value: BaggageOption.option20kg,
                            groupValue: selectedOption,
                            onChanged: (BaggageOption? value) {
                              setState(() {
                                selectedOption = value;
                              });
                              Navigator.pop(context, selectedOption);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text('25 KG'),
                          subtitle: Text('Max 1 piece'),
                          trailing: Text('SAR 200'),
                          leading: Radio<BaggageOption>(
                            value: BaggageOption.option25kg,
                            groupValue: selectedOption,
                            onChanged: (BaggageOption? value) {
                              setState(() {
                                selectedOption = value;
                              });
                              Navigator.pop(context, selectedOption);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (selectedOption != null) {
                              setState(() {
                                result = null;
                                selectedOption = null;
                                widget.Extrabaggage = null;
                                updateSelectedOption(null);
                              });
                              Navigator.pop(context, null);
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width * 0.5,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10),
                            //   border: Border.all(
                            //       // color: AppColors.LightGrayColor, // Border color
                            //       // width: 1.0, // Border width
                            //       ),
                            // ),
                            child: Center(
                              child: Text(
                                'Cancel Extra baggage',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedOption = result;
        widget.Extrabaggage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 22),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 3) - 20,
                    ),
                    const Text(
                      'Add baggage',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor),
                    ),
                  ],
                )),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20),
              child: Row(
                children: [
                  Text(deparure_from),
                  SizedBox(width: 8),
                  Icon(
                    Icons.compare_arrows_rounded,
                    color: AppColors.TextgrayColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(arrival_to)
                ],
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 10),
              child: Container(
                padding:
                    EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromARGB(255, 225, 223, 223),
                  ),
                ),
                height: 230,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconTextRow(
                            iconData: Icons.check_circle,
                            text: '7 kg cabin baggage',
                            subtext: 'Max 1 piece',
                            price: 105.87,
                            iconColor: Color.fromARGB(255, 169, 210, 158),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          IconTextRow(
                            iconData: Icons.cancel,
                            text: 'Checked baggage not included',
                            subtext: '',
                            price: 105.87,
                            iconColor: Color.fromARGB(255, 255, 67, 49),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                              onTap: () {
                                showBaggageOptions();
                              },
                              child: InkWell(
                                  onTap: () {
                                    showBaggageOptions();
                                    print(selectedOption);
                                  },
                                  child: selectedOption ==
                                              BaggageOption.option15kg ||
                                          widget.Extrabaggage ==
                                              BaggageOption.option15kg
                                      ? IconTextRow(
                                          iconData: Icons.check_circle,
                                          text: '15kg extra Checked baggage',
                                          subtext: 'Max 1 piece',
                                          price: 100.50,
                                          iconColor: const Color.fromARGB(
                                              255, 142, 191, 255))
                                      : selectedOption ==
                                                  BaggageOption.option20kg ||
                                              widget.Extrabaggage ==
                                                  BaggageOption.option20kg
                                          ? IconTextRow(
                                              iconData: Icons.check_circle,
                                              text:
                                                  '20kg extra Checked baggage',
                                              subtext: 'Max 1 piece',
                                              price: 200.87,
                                              iconColor: const Color.fromARGB(
                                                  255, 142, 191, 255))
                                          : selectedOption == BaggageOption.option25kg ||
                                                  widget.Extrabaggage ==
                                                      BaggageOption.option25kg
                                              ? IconTextRow(
                                                  iconData: Icons.check_circle,
                                                  text:
                                                      '25kg extra Checked baggage',
                                                  subtext: 'Max 1 piece',
                                                  price: 300.50,
                                                  iconColor:
                                                      const Color.fromARGB(
                                                          255, 142, 191, 255))
                                              : widget.Extrabaggage == null ||
                                                      selectedOption == null
                                                  ? Row(
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          color: AppColors
                                                              .mainColorBlue,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'Add extra baggage',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .mainColorBlue),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          color: AppColors
                                                              .mainColorBlue,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'Add extra baggage',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .mainColorBlue),
                                                        ),
                                                      ],
                                                    )))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: (MediaQuery.of(context).size.width / 3) - 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (selectedOption != null) {
                        print(selectedOption);
                        if (widget.Extrabaggage != null) {
                          Navigator.of(context).pop([selectedOption, true]);
                        } else {
                          Navigator.of(context).pop([selectedOption, false]);
                        }
                      } else if (widget.Extrabaggage != null) {
                        Navigator.of(context).pop([widget.Extrabaggage, true]);
                      } else {
                        Navigator.of(context).pop([selectedOption, true]);
                      }
                    },
                    child: Container(
                        height: 40,
                        width: 170,
                        decoration: BoxDecoration(
                          color: AppColors.darkBlue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                            child: Text(
                          'Confirm Extra Baggage',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconTextRow extends StatelessWidget {
  final IconData iconData;
  final String text;
  final String subtext;
  final Color? iconColor;
  final double price;

  const IconTextRow({
    Key? key,
    required this.iconData,
    required this.text,
    this.subtext = '',
    required this.iconColor,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      key: UniqueKey(), // Add this line

      children: [
        Icon(iconData, color: iconColor),
        SizedBox(
          width: 10,
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(text),
            Text(
              subtext,
              style: TextStyle(color: AppColors.TextgrayColor),
            ),
          ],
        ),
        Spacer(),
        Text(price.toString()),
        Text('  SAR'),
        SizedBox(
          width: 2,
        ),
      ],
    );
  }
}
