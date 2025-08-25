import 'dart:io';

import 'package:eventlyy/FireBase/firebase_services.dart';
import 'package:eventlyy/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  Future<void> updateCurrentUser(UserModel? user) async {
    currentUser = user;
    notifyListeners();
  }

  Future<void> initializeFromSavedLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        final userDoc =
            await FirebaseServices.getUserCollection()
                .doc(firebaseUser.uid)
                .get();
        if (userDoc.exists) {
          await updateCurrentUser(userDoc.data());
        }
      }
    }
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
