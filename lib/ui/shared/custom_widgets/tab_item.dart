import 'package:flutter/material.dart';
import 'package:traveling/ui/shared/colors.dart';

class TabItem extends StatelessWidget {
  final String title;
  final int count;
  const TabItem({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
          count > 0
              ? Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: AppColors.Blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(count > 9 ? '9+' : count.toString(), style: TextStyle(color: Colors.white),),
                  ),
                )
              : SizedBox(width: 0, height: 0,)
        ],
      ),
    );
  }
}
