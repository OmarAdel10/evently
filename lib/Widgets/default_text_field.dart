import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultTextField extends StatefulWidget {
  final String text;
  final IconData? icon;
  final bool hasSuffix;
  final bool hasPrefix;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const DefaultTextField({
    required this.text,
    this.icon,
    required this.controller,
    this.hasSuffix = false,
    this.hasPrefix = false,
    this.validator,
    this.maxLines = 1,
    this.onChanged
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool isEyeOn = false;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      maxLines: widget.maxLines,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: TextStyle(
        color: settingsProvider.isDark ? Apptheme.white : Apptheme.black,
      ),
      obscureText: widget.hasSuffix ? !isEyeOn : false,
      decoration: InputDecoration(
        hintText: widget.text,
        prefixIcon:
            widget.hasPrefix
                ? Icon(widget.icon, size: 24, color: Apptheme.grey)
                : null,
        suffixIcon:
            widget.hasSuffix
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      isEyeOn = !isEyeOn;
                    });
                  },
                  icon:
                      isEyeOn
                          ? Icon(CupertinoIcons.eye_fill)
                          : Icon(CupertinoIcons.eye_slash_fill),
                )
                : null,
      ),
    );
  }
}
