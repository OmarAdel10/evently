import 'package:evently/Screens/Auth/forget_password_screen.dart';
import 'package:evently/Screens/Auth/login_screen.dart';
import 'package:evently/Screens/Auth/register_screen.dart';
import 'package:evently/Screens/home_screen.dart';
import 'package:evently/Screens/onboarding/onboarding_screen.dart';
import 'package:evently/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(Evently(showHome: showHome,));
}

class Evently extends StatelessWidget {
  final bool showHome;
  Evently({required this.showHome});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
      },
      initialRoute:
          showHome ? LoginScreen.routeName : OnboardingScreen.routeName,
      theme: Apptheme.lightTheme,
      darkTheme: Apptheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
