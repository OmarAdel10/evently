import 'package:evently/apptheme.dart';
import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  Color color;

  DefaultElevatedButton({
    required this.text,
    required this.onPressed,
    this.color = Apptheme.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Apptheme.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
