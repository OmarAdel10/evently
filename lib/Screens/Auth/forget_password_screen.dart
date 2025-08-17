import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgetPassword';

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
        SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: settingsProvider.isDark ? Apptheme.darkModeBackGround : Apptheme.white,
        centerTitle: true,
        foregroundColor: Apptheme.primary,
        title: Text(
          localizations.forget_password_screen_forget_password,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Apptheme.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/forget_password.png'),
            SizedBox(height: 16),
            isPressed
                ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Apptheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                localizations.forgot_password_reset_email_title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: settingsProvider.isDark ? Apptheme.white : Apptheme.black,
                                ),
                              ),
                              SizedBox(height: 16),
                              DefaultTextField(
                                text: localizations.email,
                                icon: CupertinoIcons.mail_solid,
                                controller: _emailcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return localizations.field_can_not_be_empty;
                                  }
                                  if (value.length < 5) {
                                    return localizations.email_can_not_be_less_than_5_characters;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: DefaultElevatedButton(
                            text: localizations.forgot_password_reset_password,
                            onPressed: forgetPassword,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : SizedBox(),
            SizedBox(height: 16),
            isPressed
                ? SizedBox()
                : Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: DefaultElevatedButton(
                    text: 'Reset Password',
                    onPressed: () {
                      isPressed = true;
                      setState(() {});
                    },
                  ),
                ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future forgetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseServices.forgetPassword(
          email: _emailcontroller.text.trim(),
        );
        showCupertinoDialog(
          context: context,
          builder:
              (context) => CupertinoAlertDialog(
                content: Center(
                  child: Column(
                    children: [
                      Lottie.asset('assets/lottie/successfully.json'),
                      // SizedBox(height: 16),
                      Text('Password reset email sent!'),
                    ],
                  ),
                ),
              ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(); // Close dialog
          Navigator.of(context).pop(); // Pop screen
        });
      } on FirebaseAuthException catch (e) {
        showCupertinoDialog(
          context: context,
          builder:
              (context) => CupertinoAlertDialog(
                content: Center(
                  child: Column(
                    children: [
                      Lottie.asset('assets/lottie/Failed.json'),
                      Text(e.message.toString()),
                    ],
                  ),
                ),
              ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(); // Close dialog
        });
      }
    }
  }
}
