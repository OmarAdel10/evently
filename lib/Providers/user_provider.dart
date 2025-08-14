import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  bool checkIsEventFavourite(String eventId) {
    return currentUser!.favouriteEventsIds.contains(eventId);
  }

  void addEventToFavourites(String eventId) {
    FirebaseServices.addEventToFavourites(eventId);
    currentUser!.favouriteEventsIds.add(eventId);
    notifyListeners();
  }

  void removeEventFromFavourites(String eventId) {
    FirebaseServices.removeEventFromFavourites(eventId);
    currentUser!.favouriteEventsIds.remove(eventId);
    notifyListeners();
  }
}
