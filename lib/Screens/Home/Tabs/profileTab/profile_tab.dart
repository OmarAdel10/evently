import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Auth/login_screen.dart';
import 'package:eventlyy/Screens/Home/Tabs/profileTab/language.dart';
import 'package:eventlyy/Screens/Home/Tabs/profileTab/profile_header.dart';
import 'package:eventlyy/Screens/Home/Tabs/profileTab/themes.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations localizations = AppLocalizations.of(context)!;

    List<Language> languages = [
      Language(code: 'en', name: 'English'),
      Language(code: 'ar', name: 'Arabic'),
    ];

    List<Themes> themes = [
      Themes(code: 'light', name: 'Light'),
      Themes(code: 'dark', name: 'Dark'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Langauge row
                Row(
                  children: [
                    Text(
                      localizations.language,
                      style: textTheme.titleLarge!.copyWith(
                        color: Apptheme.black,
                      ),
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
                        onChanged: (languageCode) async {
                          if (languageCode == null) return;
                          settingsProvider.updateLanguage(languageCode);
                          bool isArabic =
                              Localizations.localeOf(context).languageCode ==
                              'ar';
                          print(isArabic);
                          if (isArabic == false) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isarabic', true);
                          } else {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isarabic', false);
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        dropdownColor: Apptheme.white,
                        iconEnabledColor: Apptheme.primary,
                        // isExpanded: true,
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
                      style: textTheme.titleLarge!.copyWith(
                        color: Apptheme.black,
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: false,
                      onChanged: (value) {},
                      activeTrackColor: Apptheme.primary,
                      inactiveThumbColor: Apptheme.white,
                      inactiveTrackColor: Apptheme.grey,
                    ),
                  ],
                ),
                Spacer(),
                // Logour button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Apptheme.red,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(16),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return GiffyDialog.lottie(
                          Lottie.asset(
                            'assets/lottie/Logout.json',
                            repeat: false,
                          ),
                          title: Text(localizations.logout),
                          titleTextStyle: TextStyle(
                            color: Apptheme.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            DefaultElevatedButton(
                              text: localizations.cancel,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            SizedBox(width: 16),
                            DefaultElevatedButton(
                              text: localizations.profile_tab_logout,
                              onPressed: () {
                                userProvider.updateCurrentUser(null);
                                Navigator.of(context).pop();
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed(LoginScreen.routeName);
                              },
                            ),
                          ],
                          entryAnimation: EntryAnimation.bottom,
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.square_arrow_right,
                        color: Apptheme.white,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        localizations.profile_tab_logout,
                        style: textTheme.titleLarge!.copyWith(
                          color: Apptheme.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
