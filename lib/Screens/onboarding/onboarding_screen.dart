import 'package:eventlyy/Screens/Auth/login_screen.dart';
import 'package:eventlyy/Screens/onboarding/onboarding.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/onboarding_logo.png'),
            SizedBox(height: 28),
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  currentindex = index;
                  setState(() {});
                },
                itemCount: Onboarding.images.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Image.asset(
                          Onboarding.images[index],
                          fit: BoxFit.fill,
                          height: MediaQuery.sizeOf(context).height * 0.35,
                        ),
                        SizedBox(height: 28),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            Onboarding.title[index],
                            // textAlign: TextAlign.start, // IDK why this doesn't work
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(height: 28),
                        Text(
                          Onboarding.subTitle[index],
                          // textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  );
                },
                controller: _controller,
              ),
            ),
            // Spacer(),
            currentindex == 0
                ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  width: double.infinity,
                  child: DefaultElevatedButton(
                    text: 'Let\'s Start',
                    onPressed: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentindex == 1
                        ? SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.15,
                        )
                        : IconButton(
                          onPressed: () {
                            _controller.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            setState(() {});
                          },
                          icon: Icon(
                            CupertinoIcons.arrow_left_circle,
                            size: 40,
                            color: Apptheme.primary,
                          ),
                        ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: Onboarding.images.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        dotColor: Apptheme.black,
                        activeDotColor: Apptheme.primary,
                      ),
                      onDotClicked: (index) {
                        _controller.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        setState(() {});
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        if (currentindex == Onboarding.images.length - 1) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('showHome', true);
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(LoginScreen.routeName);
                        } else {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        CupertinoIcons.arrow_right_circle,
                        size: 40,
                        color: Apptheme.primary,
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
