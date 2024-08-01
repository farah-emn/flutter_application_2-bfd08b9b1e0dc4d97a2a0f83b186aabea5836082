import 'package:flutter/cupertino.dart';
import 'package:traveling/classes/amenities_class.dart';
import 'package:traveling/classes/amenities_class1.dart';
import 'package:traveling/ui/shared/colors.dart';

// ignore: must_be_immutable
class AmenitiesCard1 extends StatelessWidget {
  AmenitiesCard1({
    super.key,
    required this.amenitiesModel,
    required this.itemIndex,
  });
  AmenitiesClass1 amenitiesModel;
  int itemIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            amenitiesModel.icon,
            color: AppColors.gold,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(amenitiesModel.title),
        ],
      ),
    );
  }
}
