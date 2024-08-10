import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Notes extends StatefulWidget {
  const Notes({
    super.key,
  });
  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SizedBox(
              width: 3.w,
            ),
            Container(
              width: 10.w,
              height: 5.h,
              decoration: ShapeDecoration(
                color: const Color(0xFF4D4D4D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: SvgPicture.asset(
                  'assets/icons/del.svg',
                ),
              ),
            ),
          ],
        ),
        child: Container(
          height: 15.h,
          decoration: ShapeDecoration(
            color: const Color(0xFF121212),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.white.withOpacity(0.05000000074505806),
              ),
            ),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Develop a marketing strategy to attract fans to our basketball team's games. Use data analysis to identify the target audience and come up with creative ways to attract new viewers through promotions, special offers and advertising campaigns.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
