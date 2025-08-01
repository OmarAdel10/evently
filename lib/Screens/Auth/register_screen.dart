import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Screens/Auth/login_screen.dart';
import 'package:eventlyy/Screens/Home/home_screen.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/Widgets/default_text_field.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';
  TextEditingController _namecontroller = TextEditingController();
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
                    text: 'Name',
                    icon: CupertinoIcons.mail_solid,
                    controller: _namecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Field Can Not Be Empty';
                      if (value.length < 3)
                        return 'Name Can Not be Less Than 3 Characters';
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: DefaultElevatedButton(
                      text: 'Create Account',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseServices.register(
                            name: _namecontroller.text,
                            email: _emailcontroller.text,
                            password: _passwordcontroller.text,
                          ).then(
                            (user){
                              
                              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                            }
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
                        'Already Have Account ?',
                        style: textTheme.titleMedium,
                      ),
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
      ),
    );
  }
}
