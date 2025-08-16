import 'package:eventlyy/Screens/Home/Events/create_event_screen.dart';
import 'package:eventlyy/Screens/Home/Tabs/homeTab/home_tab.dart';
import 'package:eventlyy/Screens/Home/Tabs/loveTab/love_tab.dart';
import 'package:eventlyy/Screens/Home/Tabs/mapTab/map_tab.dart';
import 'package:eventlyy/Screens/Home/Tabs/profileTab/profile_tab.dart';
import 'package:eventlyy/Screens/Home/bottom_navBar_item.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), HomeTab(),LoveTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
        AppLocalizations localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: tabs[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: 'create-event',
        onPressed:
            () => Navigator.of(context).pushNamed(CreateEventScreen.routeName),
        child: Icon(CupertinoIcons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        color: Apptheme.primary,
        height: MediaQuery.sizeOf(context).height * 0.075,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (_currentIndex == index) return;
            _currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: BottomNavbarItem(icon: CupertinoIcons.house),
              activeIcon: BottomNavbarItem(icon: CupertinoIcons.house_fill),
              label: localizations.home,
            ),
            BottomNavigationBarItem(
              icon: BottomNavbarItem(icon: CupertinoIcons.map),
              activeIcon: BottomNavbarItem(icon: CupertinoIcons.map_fill),
              label: localizations.map,
            ),
            BottomNavigationBarItem(icon: SizedBox(), label: ''),
            BottomNavigationBarItem(
              icon: BottomNavbarItem(icon: CupertinoIcons.heart),
              activeIcon: BottomNavbarItem(icon: CupertinoIcons.heart_fill),
              label: localizations.love,
            ),
            BottomNavigationBarItem(
              icon: BottomNavbarItem(icon: CupertinoIcons.person),
              activeIcon: BottomNavbarItem(icon: CupertinoIcons.person_fill),
              label: localizations.profile,
            ),
          ],
        ),
      ),
    );
  }
}
