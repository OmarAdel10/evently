import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/Screens/Auth/register_screen.dart';
import 'package:eventlyy/Screens/Home/Tabs/profileTab/language.dart';
import 'package:eventlyy/Screens/onboarding/onboarding.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  bool letsStart = false;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.sizeOf(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

    List<Language> languages = [
      Language(code: 'en', name: 'English'),
      Language(code: 'ar', name: 'Arabic'),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/onboarding_logo.png'),
            SizedBox(height: 28),
            Expanded(
              child:
                  letsStart
                      ? Column(
                        children: [
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
                                        height:
                                            size.height * 0.35,
                                      ),
                                      const SizedBox(height: 28),
                                      Align(
                                        alignment:
                                            settingsProvider.isArabic
                                                ? Alignment.topRight
                                                : Alignment.topLeft,
                                        child: Text(
                                          Onboarding.getTitle(context)[index],
                                          // textAlign: TextAlign.start, // IDK why this doesn't work
                                          style:
                                              textTheme.titleLarge,
                                        ),
                                      ),
                                      const SizedBox(height: 28),
                                      Text(
                                        Onboarding.getSubTitle(context)[index],
                                        // textAlign: TextAlign.start,
                                        style: textTheme.titleMedium!.copyWith(
                                          color:
                                              settingsProvider.isDark
                                                  ? Apptheme.white
                                                  : Apptheme.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              controller: _controller,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              currentindex == 0
                                  ? SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.15,
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
                                      settingsProvider.isArabic ? CupertinoIcons.arrow_right_circle : CupertinoIcons.arrow_left_circle,
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
                                  dotColor:
                                      settingsProvider.isDark
                                          ? Apptheme.white
                                          : Apptheme.black,
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
                                  if (currentindex ==
                                      Onboarding.images.length - 1) {
                                    Navigator.of(context).pushReplacementNamed(
                                      RegisterScreen.routeName,
                                    );
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setBool('showHome', true);
                                  } else {
                                    _controller.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                  setState(() {});
                                },
                                icon: Icon(
                                  settingsProvider.isArabic
                                      ? CupertinoIcons.arrow_left_circle
                                      : CupertinoIcons.arrow_right_circle,
                                  size: 40,
                                  color: Apptheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/onboarding_screen1.png',
                              fit: BoxFit.fill,
                              height: size.height * 0.35,
                            ),
                            const SizedBox(height: 28),
                            Align(
                              alignment: settingsProvider.isArabic ? Alignment.topRight : Alignment.topLeft,
                              child: Text(
                                localizations.onboarding_p1_title,
                                style: textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(height: 28),
                            Text(
                              localizations.onboarding_p1_description,
                              style: textTheme.titleMedium!.copyWith(
                                color:
                                    settingsProvider.isDark
                                        ? Apptheme.white
                                        : Apptheme.black,
                              ),
                            ),
                            const SizedBox(height: 31,),
                            // Langauge row
                            Row(
                              children: [
                                Text(
                                  localizations.language,
                                  style: textTheme.headlineMedium
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Apptheme.primary),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: DropdownButton(
                                    value: settingsProvider.languageCode,
                                    items:
                                        languages
                                            .map(
                                              (language) => DropdownMenuItem(
                                                value: language.code,
                                                child: Text(
                                                  language.name,
                                                  style: textTheme.titleLarge,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (languageCode){
                                      if (languageCode == null) return;
                                      settingsProvider.updateLanguage(
                                        languageCode,
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    dropdownColor: Apptheme.white,
                                    iconEnabledColor: Apptheme.primary,
                                    underline: SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Theme row
                            Row(
                              children: [
                                Text(
                                  localizations.dark_theme,
                                  style: textTheme.headlineMedium
                                ),
                                Spacer(),
                                Switch(
                                  value: settingsProvider.isDark,
                                  onChanged: (value) {
                                    settingsProvider.updateTheme(
                                      value ? ThemeMode.dark : ThemeMode.light,
                                    );
                                  },
                                  activeTrackColor: Apptheme.primary,
                                  inactiveThumbColor: Apptheme.white,
                                  inactiveTrackColor: Apptheme.grey,
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              width: double.infinity,
                              child: DefaultElevatedButton(
                                text: localizations.onboarding_p1_lets_start,
                                onPressed: () {
                                  letsStart = true;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
