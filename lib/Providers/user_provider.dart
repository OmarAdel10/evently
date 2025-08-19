import 'dart:io';

import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

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

  void updateUserName(String newName) {
    if (currentUser != null) {
      currentUser!.name = newName;
      notifyListeners();
    }
  }

  Future<void> updateProfileImage() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? imageGallery = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
      );
      if (imageGallery != null) {
        File file = File(imageGallery.path);
        String imageName = basename(imageGallery.path);
        String imageDownloadUrl = await FirebaseServices.updateProfileImage(
          imageName,
          file,
        );

        if (currentUser != null) {
          currentUser!.imageUrl = imageDownloadUrl;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error updating profile image: $e');
      rethrow;
    }
  }
}
