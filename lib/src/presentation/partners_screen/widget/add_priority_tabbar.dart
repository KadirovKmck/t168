import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddPriorityTabBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const AddPriorityTabBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  State<AddPriorityTabBar> createState() => _AddPriorityTabBarState();
}

class _AddPriorityTabBarState extends State<AddPriorityTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.h,
      decoration: ShapeDecoration(
        color: const Color(0xFF121212),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.1,
            color: Colors.white.withOpacity(0.03),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: List.generate(4, (index) => _buildPriorityItem(index)),
      ),
    );
  }

  Widget _buildPriorityItem(int index) {
    bool isSelected = widget.selectedIndex == index;
    Color textColor;
    Color borderColor = Colors.white.withOpacity(0.2);

    if (index == 0) {
      textColor = isSelected ? Colors.orange : Colors.grey;
    } else if (index == 1) {
      textColor = isSelected ? Colors.orange : Colors.grey;
    } else if (index == 2) {
      textColor = isSelected ? Colors.orange : Colors.grey;
    } else {
      textColor = isSelected ? Colors.orange : Colors.grey;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onChanged(index);
        },
        child: Container(
          height: 3.5.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: borderColor,
              width: 0,
            ),
          ),
          child: Center(
            child: Text(
              ['PROCESS', 'ACTIVELY', 'SUSPENDED', 'COMPLETED'][index],
              style: TextStyle(
                color: textColor,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
