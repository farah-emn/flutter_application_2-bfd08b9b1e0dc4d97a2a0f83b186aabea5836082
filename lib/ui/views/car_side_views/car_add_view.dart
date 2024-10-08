// ignore_for_file: non_constant_identifier_names, prefer_final_fields, unused_field, unused_local_variable, unnecessary_nullable_for_final_variable_declarations, deprecated_member_use, no_leading_underscores_for_local_identifiers, prefer_const_constructors, unused_element, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures, avoid_print, unnecessary_new

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traveling/ui/shared/text_size.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_textfield2.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class CarAddView extends StatefulWidget {
  const CarAddView({super.key});
  @override
  State<CarAddView> createState() => _CarAddViewState();
}

class _CarAddViewState extends State<CarAddView> {
  bool? isCheckedFreeWifi = false;
  bool? isCheckedPrivatePool = false;
  bool? isCheckedFoodAnddrink = false;
  bool? isCheckedPrivateParking = false;
  bool? isCheckedCleaningServices = false;

  final _Overview = TextEditingController();
  final _priceDay = TextEditingController();
  final _PriceWeek = TextEditingController();
  final _PlateNumber = TextEditingController();
  final _speed = TextEditingController();
  // final _BedRooms = TextEditingController();
  // final _NumberOfRoomAvilable = TextEditingController();
  // final _Bathrooms = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  late String errorTextRoomPhoto = '';

  List<XFile> _images = [];
  int _current = 0;
  int IdCar = 0;
  int IdAirport = 0;
  int IdPlane = 0;
  int IdStop_location = 0;
  User? car;
  var CarId = '';
  var uid;
  final _auth = FirebaseAuth.instance;
  var currentUser;
  int selectedIndex = 0;
  DatabaseReference Car = FirebaseDatabase.instance.reference().child('Car');
  List<String?> selectedValues = List.filled(0, null);
  final List<String> ChildrenAge = [
    'Under 1 year old',
    '2 year old',
    '3 year old',
    '4 year old',
    '5 year old',
    '6 year old',
    '7 year old',
    '8 year old',
    '9 year old',
    '10 year old',
    '11 year old',
    '12 year old',
    '13 year old',
    '14 year old',
    '15 year old',
    '16 year old',
    '17 year old',
  ];
  List<Color> colors = [
    Colors.black,
    Color.fromARGB(255, 255, 249, 249),
    Colors.grey,
    AppColors.darkBlue,
    Colors.red,
    Colors.brown,
  ];
  Color selectedColor = Colors.black;
  List<bool> isSelected = [true, false, false];
  List<bool> isSelectedColor = [true, false, false];
  bool _isWidgetActive = true;

  String sorteBy = 'Normal';

  @override
  void dispose() {
    _isWidgetActive = false;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    uid = currentUser?.uid;
    setState(() {
      car = _auth.currentUser;
      CarId = car?.uid.toString() ?? '';
    });
    Car.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (mounted) {
        setState(() {
          IdCar = event.snapshot.children.length + 1;
        });
      }
    });
    super.initState();
  }

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      for (var image in images) {
        if (!_images.any((x) => x.path == image.path)) {
          _images.add(image);
        }
      }
    }
    setState(() {});
  }

  bool _isLoading = false;

  Future<bool> _uploadToFirebase(
      List<XFile> images, BuildContext context) async {
    int IdOfRoomPhoto = 0;
    int IdOfChild = 0;
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('Car/$IdCar:').set({
      "CarCompanyId": CarId,
      "RentalInDay": double.parse(_priceDay.text.replaceAll('\u{00A0}', '')),
      "RentalInWeek": double.parse(_priceDay.text.replaceAll('\u{00A0}', '')),
      "model": _Overview.text,
      "Color": getColorName(selectedColor.value),
      "CarCompany": dropdownValue2,
      "Ger": sorteBy,
      "PlateNumber": _PlateNumber.text,
      "Speed": _speed.text,
      "Seats": (isSelected[0] == true)
          ? 2
          : (isSelected[1] == true)
              ? 4
              : (isSelected[2] == 2)
                  ? 6
                  : null,
      "is_reserved": false,
    });
    //image
    if (images.isNotEmpty) {
      for (var image in images) {
        IdOfRoomPhoto += 1;
        File file = File(image.path);
        var imagename = basename(image.path);
        var Firebase_Storage = FirebaseStorage.instance.ref(imagename);
        await Firebase_Storage.putFile(file);
        String url = await Firebase_Storage.getDownloadURL();
        databaseReference
            .child('Car/$IdCar:/CarPhoto')
            .update({'$IdOfRoomPhoto': url});
      }
    }

    // if (selectedValues.isNotEmpty)
    //   for (var i in selectedValues) {
    //     IdOfChild++;
    //     databaseReference
    //         .child('Room/$IdRoom:/ChildrenAge')
    //         .update({'$IdOfChild': i});
    //   }
    setState(() {
      _isWidgetActive = false;
      _isLoading = false;
    });
    setState(() {
      _Overview.clear();
      _PlateNumber.clear();
      _PriceWeek.clear();
      _priceDay.clear();
      _speed.clear();
      _images.clear();
      ChildrenAge.clear();
      isCheckedCleaningServices = false;
      isCheckedFoodAnddrink = false;
      isCheckedFreeWifi = false;
      isCheckedPrivateParking = false;
      isCheckedPrivatePool = false;
      errorTextRoomPhoto = '';
    });

    return true;
  }

  String? selectedValue;
  String dropdownValue2 = 'Toyota';

  @override
  Widget build(BuildContext context) {
    void _confirm() async {
      if (_PriceWeek.text.isNotEmpty &&
          _priceDay.text.isNotEmpty &&
          _PlateNumber.text.isNotEmpty &&
          _Overview.text.isNotEmpty &&
          selectedColor.value != '' &&
          isSelected != '' &&
          dropdownValue2 != '' &&
          sorteBy != '') {
        if (_images.length < 6) {
          setState(() {
            errorTextRoomPhoto = 'Please enter at least 6 photos';
          });
        } else if (_images.length >= 6) {
          // Show a dialog with a CircularProgressIndicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new CircularProgressIndicator(),
                    new Text("Loading"),
                  ],
                ),
              );
            },
          );

          // Call the _uploadToFirebase function
          bool uploadResult = await _uploadToFirebase(_images, context);

          // Dismiss the loading dialog regardless of the result
          if (uploadResult) {
            Navigator.pop(context);
          }
        }
      } else {
        Fluttertoast.showToast(
            msg: "Please Add all fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    String dropdownValue = 'under 1';

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Car',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/png/background1.png'),
                      fit: BoxFit.fill),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Car Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            boxShadow: List.filled(
                              10,
                              const BoxShadow(
                                  color: AppColors.gray,
                                  blurRadius: BorderSide.strokeAlignOutside,
                                  blurStyle: BlurStyle.outer),
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Car photos',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: _pickImages,
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.darkGray,
                                  ),
                                )
                              ],
                            ),
                            (errorTextRoomPhoto != null && _images.length == 0)
                                ? Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            start: 6, top: 0),
                                        child: Text(
                                          errorTextRoomPhoto,
                                          style: TextStyle(
                                              fontSize: 11, color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 15,
                                  ),
                            SizedBox(
                              height: 12,
                            ),
                            if (_images.isNotEmpty)
                              SizedBox(
                                height: 280,
                                child: Column(
                                  children: [
                                    Column(children: [
                                      Stack(
                                        children: [
                                          Center(
                                            child: Image.file(
                                              File(_images[selectedIndex].path),
                                              fit: BoxFit.contain,
                                              height: size.height / 5 + 20,
                                            ),
                                          ),
                                          Positioned(
                                            left: -12,
                                            bottom: 0,
                                            top: 0,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.keyboard_arrow_left_sharp,
                                                color: AppColors.darkGray,
                                                size: 25,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (selectedIndex > 0) {
                                                    selectedIndex--;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            right: -12,
                                            bottom: 0,
                                            top: 0,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_right_sharp,
                                                color: AppColors.darkGray,
                                                size: 25,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (selectedIndex <
                                                      _images.length - 1) {
                                                    selectedIndex++;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                    Center(
                                      child: SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _images.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = index;
                                                });
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: selectedIndex ==
                                                              index
                                                          ? AppColors.darkGray
                                                          : Colors.transparent,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Image.file(File(
                                                      _images[index].path))),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    (errorTextRoomPhoto != null)
                                        ? Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        start: 6, top: 0),
                                                child: Text(
                                                  errorTextRoomPhoto,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            height: 15,
                                          ),
                                  ],
                                ),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Model',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: size.width - 35,
                                  child: TextField(
                                    controller: _Overview,
                                    decoration: textFielDecoratiom.copyWith(
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.lightGray,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18)),
                                        ),
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(
                                          Icons.description_rounded,
                                          color: AppColors.darkGray,
                                        )),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Text(
                                  'Seats',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            ToggleButtons(
                              disabledColor: AppColors.grayText,

                              borderColor: AppColors.LightGrayColor,
                              borderRadius: BorderRadius.circular(15),
                              // focusColor: AppColors.grayText,
                              fillColor: AppColors.lightGray,
                              selectedColor: AppColors.blackColor,
                              selectedBorderColor: AppColors.lightGray,
                              color: AppColors.grayText,

                              isSelected: isSelected,
                              onPressed: (int index) {
                                setState(() {
                                  for (int i = 0; i < isSelected.length; i++) {
                                    isSelected[i] = i == index;
                                  }
                                });
                              },
                              constraints: BoxConstraints(
                                minWidth: size.width / 3 - 21.5,
                                minHeight: 40.0,
                              ),
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Text('2 Seats'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Text('4 Seats'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Text('6 Seats'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Plate Number',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grayText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: size.width / 2 - 35,
                                      child: TextField(
                                        controller: _PlateNumber,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightGray,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                            ),
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.numbers_rounded,
                                              color: AppColors.darkGray,
                                            )),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Top Speed',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grayText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: size.width / 2 - 35,
                                      child: TextField(
                                        controller: _speed,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightGray,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                            ),
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.speed,
                                              color: AppColors.darkGray,
                                            )),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Text(
                                  'Company',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Container(
                              width: size.width - 35,
                              height: 40,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.LightGrayColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                padding: EdgeInsets.only(left: 15),
                                underline: DecoratedBox(
                                  decoration: BoxDecoration(),
                                ),
                                value: dropdownValue2,
                                items: <String>[
                                  'Marceds',
                                  'KIA',
                                  'Rang Rover',
                                  'Roz Raiz',
                                  'Honday',
                                  'Honda',
                                  'Toyota',
                                  'GMC',
                                  'Odi',
                                  'BMW',
                                  'Other'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue2 = newValue!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Text(
                                  'Ger',
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
                                    Radio(
                                      activeColor: AppColors.darkGray,
                                      value: 'Normal',
                                      autofocus: true,
                                      groupValue: sorteBy,
                                      onChanged: (value) {
                                        setState(() {
                                          sorteBy = value.toString();
                                        });
                                      },
                                    ),
                                    const Text('Normal'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: AppColors.darkGray,
                                      value: 'Automatic',
                                      groupValue: sorteBy,
                                      onChanged: (value) {
                                        setState(() {
                                          sorteBy = value.toString();
                                        });
                                      },
                                    ),
                                    const Text('Automatic'),
                                  ],
                                ),
                                SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Text(
                                  'Color',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.grayText,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: colors.map((color) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = color;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: color,
                                        border: selectedColor == color
                                            ? Border.all(
                                                color: Colors.black, width: 3)
                                            : null,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            if (_isLoading)
                              Center(
                                child: CircularProgressIndicator(),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rental in day',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grayText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: size.width / 2 - 35,
                                      child: TextField(
                                        controller: _priceDay,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightGray,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                            ),
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.attach_money_sharp,
                                              color: AppColors.darkGray,
                                            )),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rental in weak',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grayText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: size.width / 2 - 35,
                                      child: TextField(
                                        controller: _PriceWeek,
                                        keyboardType: TextInputType.number,
                                        decoration: textFielDecoratiom.copyWith(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.lightGray,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                            ),
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.attach_money_sharp,
                                              color: AppColors.darkGray,
                                            )),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: _confirm,
                        child: CustomButton(
                          backgroundColor: AppColors.darkGray,
                          text: 'Add',
                          textColor: Colors.white,
                          widthPercent: size.width,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
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

String getColorName(int color) {
  Map<int, String> colorNames = {
    4286141768: 'Brown',
    4294198070: 'Red',
    4281626336: 'Blue',
    4288585374: 'Grey',
    4294965753: 'White',
    4278190080: 'Black',
    // Color(0xFF000000): 'Black',
    // Color(0xFFFFFFF9): 'white ',
  };
  print(colorNames[color]);
  return colorNames[color] ?? 'Unknown Color';
}
