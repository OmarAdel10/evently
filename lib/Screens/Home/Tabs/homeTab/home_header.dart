import 'package:eventlyy/Models/category_model.dart';
import 'package:eventlyy/Screens/Home/Tabs/homeTab/tabBar_item.dart';
import 'package:eventlyy/apptheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  final void Function(CategoryModel? category) filterEvents;
  HomeHeader({required this.filterEvents});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Apptheme.primary,
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
            Text('Welcome Back ✨', style: textTheme.titleSmall),
            Text('User Name', style: textTheme.headlineSmall),
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
                  widget.filterEvents(selectedCategory);
                  setState(() {});
                },
                tabs: [
                  TabbarItem(
                    icon: CupertinoIcons.compass,
                    label: 'All',
                    isSelected: _currentIndex == 0,
                    selectedBackgroundColor: Apptheme.white,
                    selectedForegroundColor: Apptheme.primary,
                    unselectedForegroundColor: Apptheme.white,
                  ),
                  ...CategoryModel.categories.map(
                    (category) => TabbarItem(
                      icon: category.icon,
                      label: category.name,
                      isSelected:
                          _currentIndex ==
                          CategoryModel.categories.indexOf(category) + 1,
                      selectedBackgroundColor: Apptheme.white,
                      selectedForegroundColor: Apptheme.primary,
                      unselectedForegroundColor: Apptheme.white,
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
