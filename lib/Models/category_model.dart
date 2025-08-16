import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CategoryModel {
  String id;
  String name;
  IconData icon;
  String imageName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageName,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Sport',
      icon: CupertinoIcons.sportscourt,
      imageName: 'sport',
    ),
    CategoryModel(
      id: '2',
      name: 'Birthday',
      icon: CupertinoIcons.gift,
      imageName: 'birthday',
    ),
    CategoryModel(
      id: '3',
      name: 'Meeting',
      icon: CupertinoIcons.calendar,
      imageName: 'meeting',
    ),
    CategoryModel(
      id: '4',
      name: 'Gaming',
      icon: CupertinoIcons.gamecontroller,
      imageName: 'gaming',
    ),
    CategoryModel(
      id: '5',
      name: 'Eating',
      icon: Icons.restaurant_sharp,
      imageName: 'eating',
    ),
    CategoryModel(
      id: '6',
      name: 'Holiday',
      icon: CupertinoIcons.airplane,
      imageName: 'holiday',
    ),
    CategoryModel(
      id: '7',
      name: 'Exhibition',
      icon: CupertinoIcons.bag,
      imageName: 'exhibition',
    ),
    CategoryModel(
      id: '8',
      name: 'Workshop',
      icon: CupertinoIcons.paperclip,
      imageName: 'workshop',
    ),
    CategoryModel(
      id: '9',
      name: 'Bookclub',
      icon: CupertinoIcons.book,
      imageName: 'bookclub',
    ),
  ];
}
