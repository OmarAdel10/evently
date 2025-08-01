import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Screens/Auth/forget_password_screen.dart';
import 'package:eventlyy/Screens/Auth/register_screen.dart';
import 'package:eventlyy/Screens/Home/home_screen.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),

                  Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.2,
                  ),
                  SizedBox(height: 24),
                  DefaultTextField(
                    text: 'Email',
                    icon: CupertinoIcons.mail_solid,
                    controller: _emailcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Field Can Not Be Empty';
                      if (value.length < 5)
                        return 'Email Can Not be Less Than 5 Characters';
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DefaultTextField(
                    text: 'Password',
                    icon: CupertinoIcons.padlock_solid,
                    controller: _passwordcontroller,
                    hasSuffix: true,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Field Can Not Be Empty';
                      if (value.length < 8)
                        return 'Password Can Not be Less Than 8 Characters';
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(ForgetPasswordScreen.routeName);
                      },
                      child: Text(
                        'Forget Password?',
                        style: textTheme.titleMedium!.copyWith(
                          color: Apptheme.primary,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: DefaultElevatedButton(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseServices.login(
                            email: _emailcontroller.text,
                            password: _passwordcontroller.text,
                          ).then(
                            (user) => Navigator.of(
                              context,
                            ).pushReplacementNamed(HomeScreen.routeName),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t Have Account ?',
                        style: textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(RegisterScreen.routeName);
                        },
                        child: Text(
                          'Create Account',
                          style: textTheme.titleMedium!.copyWith(
                            color: Apptheme.primary,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Apptheme.primary,
                          thickness: 1,
                          indent: size.width * 0.1,
                        ),
                      ),
                      Text(
                        '     Or     ',
                        style: textTheme.titleMedium!.copyWith(
                          color: Apptheme.primary,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Apptheme.primary,
                          thickness: 1,
                          endIndent: size.width * 0.1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      backgroundColor: Apptheme.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: BorderSide(width: 1, color: Apptheme.primary),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google.png'),
                        SizedBox(width: 10),
                        Text(
                          'Login With Google',
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
