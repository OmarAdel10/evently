import 'package:evently/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DefaultTextField extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool hasSuffix;
  final TextEditingController controller;
  const DefaultTextField({ 
    required this.text,
    required this.icon,
    required this.controller,
    this.hasSuffix = false,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool isEyeOn = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.hasSuffix ? !isEyeOn : false,
      decoration: InputDecoration(
        hintText: widget.text,
        prefixIcon: Icon(widget.icon, size: 24, color: Apptheme.grey),
        suffixIcon: widget.hasSuffix
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isEyeOn = !isEyeOn;
                  });
                },
                icon: isEyeOn
                    ? Icon(CupertinoIcons.eye_fill)
                    : Icon(CupertinoIcons.eye_slash_fill),
              )
            : null,
      ),
    );
  }
}
