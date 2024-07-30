import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';
import '../classes/reviews_class.dart';

class ReviewCard extends StatelessWidget {
  final ReviewsClass reviewList;
  final int itemIndex;
  const ReviewCard(
      {super.key, required this.itemIndex, required this.reviewList});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 120,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 1),
              blurRadius: 4,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: SizedBox(
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    reviewList.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    reviewList.date,
                    style: const TextStyle(
                        color: AppColors.TextgrayColor, fontSize: 12),
                  ),
                ],
              ),
              Text(reviewList.comment),
            ],
          ),
        ),
      ),
    ]);
  }
}
