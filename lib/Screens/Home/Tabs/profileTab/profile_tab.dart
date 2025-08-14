import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Auth/login_screen.dart';
import 'package:eventlyy/Screens/Home/Tabs/profileTab/language.dart';
import 'package:eventlyy/Screens/Home/Tabs/profileTab/profile_header.dart';
import 'package:eventlyy/Screens/Home/Tabs/profileTab/themes.dart';
import 'package:eventlyy/Widgets/default_elevated_button.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language',
                style: textTheme.titleLarge!.copyWith(color: Apptheme.black),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Apptheme.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButton(
                  value: 'en',
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
                  onChanged: (value) {},
                  borderRadius: BorderRadius.circular(16),
                  dropdownColor: Apptheme.white,
                  iconEnabledColor: Apptheme.primary,
                  isExpanded: true,
                  underline: SizedBox(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Theme',
                style: textTheme.titleLarge!.copyWith(color: Apptheme.black),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Apptheme.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButton(
                  value: 'light',
                  items:
                      themes
                          .map(
                            (theme) => DropdownMenuItem(
                              value: theme.code,
                              child: Text(
                                theme.name,
                                style: textTheme.titleLarge,
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {},
                  borderRadius: BorderRadius.circular(16),
                  dropdownColor: Apptheme.white,
                  iconEnabledColor: Apptheme.primary,
                  isExpanded: true,
                  underline: SizedBox(),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
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
                        title: Text('Logout?'),
                        titleTextStyle: TextStyle(
                          color: Apptheme.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          DefaultElevatedButton(
                            text: 'Cancel',
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          SizedBox(width: 16),
                          DefaultElevatedButton(
                            text: 'Logout',
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
                      'Logout',
                      style: textTheme.titleLarge!.copyWith(
                        color: Apptheme.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
