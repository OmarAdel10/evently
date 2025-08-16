import 'package:flutter/material.dart';

class TabbarItem extends StatelessWidget {
  IconData icon;
  String label;
  bool isSelected;
  Color selectedBackgroundColor;
  Color selectedForegroundColor;
  Color unselectedForegroundColor;
  TabbarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.selectedBackgroundColor,
    required this.selectedForegroundColor,
    required this.unselectedForegroundColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: unselectedForegroundColor),
        borderRadius: BorderRadius.circular(46),
        color: isSelected ? selectedBackgroundColor : Colors.transparent,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color:
                isSelected
                    ? selectedForegroundColor
                    : unselectedForegroundColor,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color:
                  isSelected
                      ? selectedForegroundColor
                      : unselectedForegroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
