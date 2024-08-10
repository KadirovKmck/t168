import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ContainerTasks extends StatelessWidget {
  const ContainerTasks({
    super.key,
    required this.count,
    required this.subTitle,
    required this.countColor,
  });

  final String count;
  final String subTitle;
  final Color countColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: const Color(0xFF272727),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(
              color: countColor,
              fontSize: 18.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: const Color(0xFFF5F5F5),
              fontSize: 13.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
