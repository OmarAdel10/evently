import 'package:eventlyy/Screens/Home/Events/event_item.dart';
import 'package:eventlyy/Screens/Home/Tabs/homeTab/home_header.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.all(16),
            itemBuilder: (_, index) => EventItem(),
            separatorBuilder: (_, __) => SizedBox(height: 16),
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
