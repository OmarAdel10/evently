import 'package:eventlyy/Models/category_model.dart';
import 'package:eventlyy/Providers/event_provider.dart';
import 'package:eventlyy/Providers/settings_provider.dart';
import 'package:eventlyy/Providers/user_provider.dart';
import 'package:eventlyy/Screens/Home/Tabs/homeTab/tabBar_item.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations localizations = AppLocalizations.of(context)!;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color:
            settingsProvider.isDark
                ? Apptheme.darkModeBackGround
                : Apptheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  Text(
                    '${localizations.home_screen_welcome_back} ✨',
                    style: textTheme.titleSmall,
                  ),
                  Text(
                    userProvider.currentUser!.name,
                    style: textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            DefaultTabController(
              length: CategoryModel.categories.length + 1,
              child: TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.only(right: 10),
                onTap: (index) {
                  if (_currentIndex == index) return;
                  _currentIndex = index;
                  CategoryModel? selectedCategory =
                      _currentIndex == 0
                          ? null
                          : CategoryModel.categories[_currentIndex - 1];
                  eventProvider.filterEvents(selectedCategory);
                  setState(() {});
                },
                tabs: [
                  TabbarItem(
                    icon: CupertinoIcons.compass,
                    label: 'All',
                    isSelected: _currentIndex == 0,
                    selectedBackgroundColor:
                        settingsProvider.isDark
                            ? Apptheme.primary
                            : Apptheme.white,
                    selectedForegroundColor:
                        settingsProvider.isDark
                            ? Apptheme.white
                            : Apptheme.primary,
                    unselectedForegroundColor: Apptheme.white,
                    borderColor: Apptheme.primary,
                  ),
                  ...CategoryModel.categories.map(
                    (category) => TabbarItem(
                      icon: category.icon,
                      label: category.name,
                      isSelected:
                          _currentIndex ==
                          CategoryModel.categories.indexOf(category) + 1,
                      selectedBackgroundColor:
                          settingsProvider.isDark
                              ? Apptheme.primary
                              : Apptheme.white,
                      selectedForegroundColor:
                          settingsProvider.isDark
                              ? Apptheme.white
                              : Apptheme.primary,
                      unselectedForegroundColor: Apptheme.white,
                      borderColor: Apptheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
