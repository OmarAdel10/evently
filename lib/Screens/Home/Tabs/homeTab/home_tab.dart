import 'package:eventlyy/Models/category_model.dart';
import 'package:eventlyy/Providers/event_provider.dart';
import 'package:eventlyy/Screens/Home/Events/event_item.dart';
import 'package:eventlyy/Screens/Home/Tabs/homeTab/home_header.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  CategoryModel? selectedCategory;
  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    return Column(
      children: [
        HomeHeader(selectedCategoryName: selectedCategoryName),
        Expanded(
          child:
              eventProvider.dispalyedEvents.isEmpty
                  ? Column(
                    children: [
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
                      Lottie.asset('assets/lottie/EmptyBox.json'),
                      const SizedBox(height: 16,),
                      Text(
                        'No ${selectedCategory!.name} Events Found',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  )
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

  void selectedCategoryName(CategoryModel? selectedCategoryName) {
    selectedCategory = selectedCategoryName;
  }
}
