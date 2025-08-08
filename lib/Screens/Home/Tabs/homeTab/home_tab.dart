import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Models/category_model.dart';
import 'package:eventlyy/Models/event_model.dart';
import 'package:eventlyy/Screens/Home/Events/event_item.dart';
import 'package:eventlyy/Screens/Home/Tabs/homeTab/home_header.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> allEvents = [];
  List<EventModel> dispalyedEvents = [];

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeader(filterEvents: filterEvents),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.all(16),
            itemBuilder: (_, index) => EventItem(event: dispalyedEvents[index]),
            separatorBuilder: (_, __) => SizedBox(height: 16),
            itemCount: dispalyedEvents.length,
          ),
        ),
      ],
    );
  }

  Future<void> getEvents() async {
    allEvents = await FirebaseServices.getEvents();
    dispalyedEvents = allEvents;
    setState(() {});
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      dispalyedEvents = allEvents;
    } else {
    dispalyedEvents =
        allEvents.where((event) => event.category == category).toList();
    }
    setState(() {});
  }
}
