// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, non_constant_identifier_names, must_be_immutable, use_build_context_synchronously

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
// import 'package:flutter_ocr_sdk/flutter_ocr_sdk_platform_interface.dart';
// import 'package:flutter_ocr_sdk/mrz_line.dart';
// import 'package:flutter_ocr_sdk/mrz_parser.dart';
// import 'package:flutter_ocr_sdk/mrz_result.dart';
// import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/scan_traveller_id/camera_view.dart';
// import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/scan_traveller_id/global.dart';
// import 'package:traveling/ui/views/traveller_side_views/flight_travellers_view_details/scan_traveller_id/utils.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:image_picker/image_picker.dart';
// import 'dart:ui' as ui;
// import 'dart:typed_data';

// class ScanId extends StatefulWidget {
//   final TextEditingController firstname_con;
//   final TextEditingController lastname_con;
//   final TextEditingController nationality_con;
//   final TextEditingController dateofbirth_con;
//   final TextEditingController passportnumber_con;
//   final TextEditingController issuingcountry_con;
//   final TextEditingController expiredate_con;
//   var gender;

//   ScanId(
//       {super.key,
//       required this.firstname_con,
//       required this.lastname_con,
//       required this.nationality_con,
//       required this.dateofbirth_con,
//       required this.passportnumber_con,
//       required this.issuingcountry_con,
//       required this.expiredate_con,
//       this.gender});

//   @override
//   State<ScanId> createState() => _ScanIdState();
// }

// class _ScanIdState extends State<ScanId> {
//   final picker = ImagePicker();

//   void openResultPage(MrzResult information) {
//     // ResultPage(information: information);
//     widget.firstname_con.text = information.givenName!;
//     widget.lastname_con.text = information.surname!;
//     widget.nationality_con.text = information.nationality!;
//     widget.dateofbirth_con.text = information.birthDate!;
//     widget.passportnumber_con.text = information.passportNumber!;
//     widget.issuingcountry_con.text = information.issuingCountry!;
//     widget.expiredate_con.text = information.expiration!;
//     widget.gender = information.gender!;
//     Navigator.pop(context, information);
//   }

//   void scanImage() async {
//     XFile? photo = await picker.pickImage(source: ImageSource.gallery);

//     if (photo == null) {
//       return;
//     }

//     if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
//       File rotatedImage =
//           await FlutterExifRotation.rotateImage(path: photo.path);
//       photo = XFile(rotatedImage.path);
//     }

//     Uint8List fileBytes = await photo.readAsBytes();

//     ui.Image image = await decodeImageFromList(fileBytes);

//     ByteData? byteData =
//         await image.toByteData(format: ui.ImageByteFormat.rawRgba);
//     if (byteData != null) {
//       List<List<MrzLine>>? results = await mrzDetector.recognizeByBuffer(
//           byteData.buffer.asUint8List(),
//           image.width,
//           image.height,
//           byteData.lengthInBytes ~/ image.height,
//           ImagePixelFormat.IPF_ARGB_8888.index);
//       List<MrzLine>? finalArea;
//       var information;
//       if (results != null && results.isNotEmpty) {
//         for (List<MrzLine> area in results) {
//           if (area.length == 2) {
//             finalArea = area;
//             information = MRZ.parseTwoLines(area[0].text, area[1].text);
//             information.lines = '${area[0].text}\n${area[1].text}';
//             break;
//           } else if (area.length == 3) {
//             finalArea = area;
//             information =
//                 MRZ.parseThreeLines(area[0].text, area[1].text, area[2].text);
//             information.lines =
//                 '${area[0].text}\n${area[1].text}\n${area[2].text}';
//             break;
//           }
//         }
//       }
//       if (finalArea != null) {
//         openResultPage(information!);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final title = Row(
//       children: [
//         Container(
//             padding: const EdgeInsets.only(
//               top: 30,
//               left: 33,
//             ),
//             child: const Text('MRZ SCANNER',
//                 style: TextStyle(
//                   fontSize: 36,
//                   color: Colors.white,
//                 )))
//       ],
//     );
//     final info = Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Use your passport or GCC National ID to quickly and securely auto-fill traveller /n details.',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20),
//           BulletPoint(
//             text:
//                 'Make sure to scan the side with the ID code displayed (shown above).',
//             icon: Icons.info_outline,
//           ),
//           BulletPoint(
//             text: "We'll need access to your camera to scan the document.",
//             icon: Icons.camera_alt_outlined,
//           ),
//           BulletPoint(
//             text:
//                 'Your information is secure and your ID image will not be saved.',
//             icon: Icons.check_circle_outline,
//           ),
//         ],
//       ),
//     );

//     final description = Row(
//       children: [
//         Container(
//             padding: const EdgeInsets.only(top: 6, left: 33, bottom: 44),
//             child: const SizedBox(
//               width: 271,
//               child: Text(
//                   'Recognizes MRZ code & extracts data from 1D-codes, passports, and visas.',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                   )),
//             ))
//       ],
//     );

//     final buttons = Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         GestureDetector(
//             onTap: () async {
//               if (!kIsWeb && Platform.isLinux) {
//                 showAlert(context, "Warning",
//                     "${Platform.operatingSystem} is not supported");
//                 return;
//               }

//               MrzResult? TravellerData = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CameraPage(
//                       firstname_con: widget.firstname_con,
//                       lastname_con: widget.lastname_con,
//                       dateofbirth_con: widget.dateofbirth_con,
//                       passportnumber_con: widget.passportnumber_con,
//                       issuingcountry_con: widget.issuingcountry_con,
//                       expiredate_con: widget.expiredate_con,
//                       nationality_con: widget.nationality_con,
//                       gender: widget.gender),
//                 ),
//               );

//               if (TravellerData != null) {
//                 widget.firstname_con.text = TravellerData.givenName ?? '';
//                 widget.lastname_con.text = TravellerData.surname ?? '';
//                 widget.nationality_con.text = TravellerData.nationality ?? '';
//                 widget.passportnumber_con.text =
//                     TravellerData.passportNumber ?? '';
//                 Navigator.pop(context, TravellerData);
//               }
//             },
//             child: Container(
//               width: 385,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Image.asset(
//                       //   "images/icon-camera.png",
//                       //   width: 40,
//                       //   height: 30,
//                       // ),
//                       SizedBox(
//                         width: 3,
//                       ),
//                       Text(
//                         'Camera Scan',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )),
//         SizedBox(
//           height: 20,
//         ),
//         GestureDetector(
//             onTap: () {
//               scanImage();
//             },
//             child: Container(
//               width: 385,
//               height: 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.blue, // Border color
//                   width: 1.0, // Border width
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Icon(
//                     Icons.photo_camera_outlined,
//                     color: Colors.blue,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     'Select a photo',
//                     style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16),
//                   ),
//                 ],
//               ),
//             ))
//       ],
//     );

//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           title,
//           SizedBox(
//             height: 240,
//           ),
//           info,
//           description,
//           // SizedBox(height: 220),
//           buttons,
//           const SizedBox(
//             height: 34,
//           ),
//           Expanded(
//               child: Stack(
//             children: [
//               if (!isLicenseValid)
//                 Opacity(
//                   opacity: 0.8,
//                   child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: 40,
//                       color: const Color(0xffFF1A1A),
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       child: InkWell(
//                           onTap: () {
//                             launchUrlString(
//                                 'https://www.dynamsoft.com/customer/license/trialLicense?product=dlr');
//                           },
//                           child: const Row(
//                             children: [
//                               Icon(Icons.warning_amber_rounded,
//                                   color: Colors.white, size: 20),
//                               Text(
//                                 "  License expired! Renew your license ->",
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ))),
//                 )
//             ],
//           ))
//         ],
//       ),
//     );
//   }
// }

// class BulletPoint extends StatelessWidget {
//   final String text;
//   final IconData icon;

//   const BulletPoint({Key? key, required this.text, required this.icon})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: <Widget>[
//           Icon(
//             icon,
//             size: 24,
//             color: const Color.fromARGB(255, 149, 148, 148),
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(color: const Color.fromARGB(255, 149, 148, 148)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
