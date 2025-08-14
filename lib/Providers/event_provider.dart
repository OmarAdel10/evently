import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Models/category_model.dart';
import 'package:eventlyy/Models/event_model.dart';
import 'package:flutter/widgets.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> dispalyedEvents = [];
  List<EventModel> favouriteEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseServices.getEvents();
    dispalyedEvents = allEvents;
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      dispalyedEvents = allEvents;
    } else {
      dispalyedEvents =
          allEvents.where((event) => event.category == category).toList();
    }
    notifyListeners();
  }

  void filterFavouriteEvents(List<String> favouriteIds) {
    favouriteEvents =
        allEvents.where((event) => favouriteIds.contains(event.id)).toList();
    notifyListeners();
  }
}
