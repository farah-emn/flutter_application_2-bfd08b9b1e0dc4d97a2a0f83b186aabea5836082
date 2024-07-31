import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:traveling/classes/hotel.dart';
import 'package:traveling/classes/hotel_room_details_class1.dart';
import 'package:traveling/ui/shared/colors.dart';
import 'package:traveling/ui/shared/text_size.dart';
import 'package:traveling/ui/views/hotel_side_views/hotel_room_view.dart';

import '../ui/views/traveller_side_views/room_view.dart';
import '../classes/hotel_room_details_class.dart';

class HotelCard2 extends StatefulWidget {
  const HotelCard2({
    super.key,
    required this.size,
    required this.room,
    required this.itemIndex,
  });

  final Size size;
  final HotelRoomClass1 room;
  final int itemIndex;

  @override
  State<HotelCard2> createState() => _HotelCard2State();
}

class _HotelCard2State extends State<HotelCard2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.to(
          const RoomView(),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: List.filled(
            10,
            const BoxShadow(
                color: AppColors.gray,
                blurRadius: BorderSide.strokeAlignOutside,
                blurStyle: BlurStyle.outer),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        width: widget.size.width - 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage(widget.room.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: size.width / 2,
              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    softWrap: true,
                    widget.room.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: TextSize.header1,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.bed,
                                color: AppColors.purple,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.room.beds,
                                style: const TextStyle(
                                    color: AppColors.grayText,
                                    fontSize: TextSize.header2),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.window,
                                color: AppColors.purple,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.room.view,
                                style: const TextStyle(
                                    color: AppColors.grayText,
                                    fontSize: TextSize.header2),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_half_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                          Icon(
                            Icons.star_border_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                        ],
                      ),
                      Text(
                        '100\$',
                        style: TextStyle(
                            color: AppColors.purple,
                            fontSize: TextSize.header1,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
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


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
// import 'package:traveling/classes/hotel.dart';
// import 'package:traveling/ui/shared/colors.dart';
// import 'package:traveling/ui/shared/text_size.dart';
// import 'package:traveling/ui/views/hotel_side_views/hotel_room_view.dart';

// import '../ui/views/traveller_side_views/room_view.dart';
// import '../classes/hotel_room_details_class.dart';

// class HotelCard2 extends StatefulWidget {
//   const HotelCard2({
//     super.key,
//     required this.size,
//     required this.room,
//     required this.itemIndex,
//   });

//   final Size size;
//   final HotelRoomClass room;
//   final int itemIndex;

//   @override
//   State<HotelCard2> createState() => _HotelCard2State();
// }

// class _HotelCard2State extends State<HotelCard2> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.to(
//           const RoomView(),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(
//           bottom: 20,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: List.filled(
//             10,
//             const BoxShadow(
//                 color: AppColors.gray,
//                 blurRadius: BorderSide.strokeAlignOutside,
//                 blurStyle: BlurStyle.outer),
//           ),
//           borderRadius: const BorderRadius.all(
//             Radius.circular(20),
//           ),
//         ),
//         width: widget.size.width - 30,
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   height: 200,
//                   width: widget.size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                     image: DecorationImage(
//                       image: AssetImage(widget.room.image),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         child: Text(
//                           widget.room.name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: TextSize.header1,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5,),
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.location_on,
//                                 color: AppColors.purple,
//                                 size: 20,
//                               ),
//                               Text(
//                                 widget.room.price,
//                                 style: const TextStyle(
//                                     color: AppColors.grayText,
//                                     fontSize: TextSize.header2),
//                               ),
//                             ],
//                           ),
//                           const Row(
//                             children: [
//                               Icon(
//                                 Icons.star_rounded,
//                                 color: AppColors.gold,
//                                 size: 20,
//                               ),
//                               Icon(
//                                 Icons.star_rounded,
//                                 color: AppColors.gold,
//                                 size: 20,
//                               ),
//                               Icon(
//                                 Icons.star_rounded,
//                                 color: AppColors.gold,
//                                 size: 20,
//                               ),
//                               Icon(
//                                 Icons.star_half_rounded,
//                                 color: AppColors.gold,
//                                 size: 20,
//                               ),
//                               Icon(
//                                 Icons.star_border_rounded,
//                                 color: AppColors.gold,
//                                 size: 20,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       const Column(
//                         children: [
//                           Text(
//                             'Per night:',
//                             style: TextStyle(
//                               color: AppColors.grayText,
//                             ),
//                           ),
//                           Text(
//                             '100\$',
//                             style: TextStyle(
//                                 color: AppColors.purple,
//                                 fontSize: TextSize.header1,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
