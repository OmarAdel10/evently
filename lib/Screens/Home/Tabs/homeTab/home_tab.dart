import 'package:eventlyy/Providers/event_provider.dart';
import 'package:eventlyy/Screens/Home/Events/event_item.dart';
import 'package:eventlyy/Screens/Home/Tabs/homeTab/home_header.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    return Column(
      children: [
        HomeHeader(),
        Expanded(
          child:
              eventProvider.dispalyedEvents.isEmpty
                  ? Lottie.asset('assets/lottie/EmptyBox.json')
                  : ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemBuilder:
                        (_, index) => EventItem(
                          event: eventProvider.dispalyedEvents[index],
                        ),
                    separatorBuilder: (_, __) => SizedBox(height: 16),
                    itemCount: eventProvider.dispalyedEvents.length,
                  ),
        ),
      ],
    );
  }
}
