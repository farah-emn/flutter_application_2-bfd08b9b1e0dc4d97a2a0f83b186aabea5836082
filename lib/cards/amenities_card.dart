import 'package:flutter/cupertino.dart';
import 'package:traveling/ui/shared/colors.dart';
import '../classes/amenities_class.dart';

// ignore: must_be_immutable
class AmenitiesCard extends StatelessWidget {
  AmenitiesCard({
    super.key,
    required this.amenitiesModel,
    required this.itemIndex,
  });
  AmenitiesClass amenitiesModel;
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
