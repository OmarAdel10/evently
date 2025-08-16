import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavbarItem extends StatelessWidget {
  IconData icon;
  bool? isSelected;

  BottomNavbarItem({required this.icon,this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 24);
  }
}
