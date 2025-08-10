import 'package:eventlyy/Providers/event_provider.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Auth/forget_password_screen.dart';
import 'package:eventlyy/Screens/Auth/login_screen.dart';
import 'package:eventlyy/Screens/Auth/register_screen.dart';
import 'package:eventlyy/Screens/Home/Events/create_event_screen.dart';
import 'package:eventlyy/Screens/Home/home_screen.dart';
import 'package:eventlyy/Screens/onboarding/onboarding_screen.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  await Firebase.initializeApp(
    // options: FirebaseOptions(
    //   apiKey: "AIzaSyCF45als5LN3ARHTCrjQ5NvLe4VxODx6Og",
    //   appId: "1:187369570776:android:d8d7e0d5a7b8a6ba53b2ad",
    //   messagingSenderId: "187369570776",
    //   projectId: "evently-b591c",
    // ),
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => EventProvider()..getEvents(),),
      ChangeNotifierProvider(create: (context) => UserProvider(),),
    ],
    child: Evently(showHome: showHome)));
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
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
      },
      // initialRoute:
      //     showHome ? LoginScreen.routeName : OnboardingScreen.routeName,
      initialRoute: HomeScreen.routeName,
      theme: Apptheme.lightTheme,
      darkTheme: Apptheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
