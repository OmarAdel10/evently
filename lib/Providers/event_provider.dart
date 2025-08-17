import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Models/category_model.dart';
import 'package:eventlyy/Models/event_model.dart';
import 'package:flutter/widgets.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> dispalyedEvents = [];
  List<EventModel> favouriteEvents = [];
  List<EventModel> displayedFavouriteEvents = [];

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
    displayedFavouriteEvents = favouriteEvents;
    notifyListeners();
  }

  void searchResult(String query) {
    if (query.isEmpty) {
      displayedFavouriteEvents = favouriteEvents;
    } else {
      displayedFavouriteEvents =
          favouriteEvents
              .where(
                (event) =>
                    event.title.toLowerCase().contains(query.toLowerCase()) ||
                    event.description.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
    }
    notifyListeners();
  }
}
