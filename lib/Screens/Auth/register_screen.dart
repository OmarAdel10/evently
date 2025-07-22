import 'package:evently/Screens/Auth/login_screen.dart';
import 'package:evently/Widgets/default_elevated_button.dart';
import 'package:evently/Widgets/default_text_field.dart';
import 'package:evently/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', height: size.height * 0.2),
                SizedBox(height: 24),
                DefaultTextField(
                  text: 'Name',
                  icon: CupertinoIcons.mail_solid,
                  controller: _namecontroller,
                ),
                SizedBox(height: 16),
                DefaultTextField(
                  text: 'Email',
                  icon: CupertinoIcons.mail_solid,
                  controller: _emailcontroller,
                ),
                SizedBox(height: 16),
                DefaultTextField(
                  text: 'Password',
                  icon: CupertinoIcons.padlock_solid,
                  controller: _passwordcontroller,
                  hasSuffix: true,
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: DefaultElevatedButton(text: 'Login', onPressed: () {}),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have Account ?', style: textTheme.titleMedium),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Text(
                        'Login',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
