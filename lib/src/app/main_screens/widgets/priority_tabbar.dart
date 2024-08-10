import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PriorityTabBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const PriorityTabBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  State<PriorityTabBar> createState() => _PriorityTabBarState();
}

class _PriorityTabBarState extends State<PriorityTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: List.generate(3, (index) => _buildPriorityItem(index)),
      ),
    );
  }

  Widget _buildPriorityItem(int index) {
    bool isSelected = widget.selectedIndex == index;
    Color textColor;

    if (index == 0) {
      textColor = isSelected ? Colors.green : Colors.grey; // Low priority
    } else if (index == 1) {
      textColor = isSelected ? Colors.orange : Colors.grey; // Medium priority
    } else {
      textColor = isSelected ? Colors.red : Colors.grey; // High priority
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onChanged(index);
        },
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Text(
              ['Low', 'Medium', 'High'][index],
              style: TextStyle(
                color: textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
