import 'package:evently/Widgets/default_elevated_button.dart';
import 'package:evently/apptheme.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgetPassword';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Apptheme.white,
        centerTitle: true,
        foregroundColor: Apptheme.black,
        title: Text(
          'Forget Password',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Apptheme.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          Image.asset('assets/images/forget_password.png'),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: DefaultElevatedButton(text: 'Reset Password', onPressed: () {}),
          ),
          SizedBox(height: 8,),
          Text('< Does\'t work right now ! >', style: TextStyle(color: Apptheme.grey.withValues(alpha: 0.5), fontWeight: FontWeight.w900),)
        ],
      ),
    );
  }
}
