import 'package:evently/Screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Evently());
}


class Evently extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      // initialRoute: ,
    );
  }
}