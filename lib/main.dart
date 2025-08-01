import 'package:eventlyy/Screens/Auth/forget_password_screen.dart';
import 'package:eventlyy/Screens/Auth/login_screen.dart';
import 'package:eventlyy/Screens/Auth/register_screen.dart';
import 'package:eventlyy/Screens/Home/home_screen.dart';
import 'package:eventlyy/Screens/onboarding/onboarding_screen.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  await Firebase.initializeApp();
  runApp(Evently(showHome: showHome,));
}

class Evently extends StatelessWidget {
  final bool showHome;
  const Evently({super.key, required this.showHome});
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
      // initialRoute:
      //     showHome ? LoginScreen.routeName : OnboardingScreen.routeName,
      initialRoute: LoginScreen.routeName,
      theme: Apptheme.lightTheme,
      darkTheme: Apptheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
