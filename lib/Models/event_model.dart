import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyy/Models/category_model.dart';

class EventModel {
  String id;
  String userId;
  String title;
  String description;
  CategoryModel category;
  DateTime dateTime;

  EventModel({
    this.id = '',
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.dateTime,
  });

  EventModel.fromJSON(Map<String, dynamic> json) : this(
    id: json['id'],
    userId: json['userId'],
    title: json['title'],
    description: json['description'],
    category: CategoryModel.categories.firstWhere((category) => category.id == json['category']),
    dateTime: (json['dateTime'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJSON() => {
    'id': id,
    'userId': userId,
    'title': title,
    'description': description,
    'category': category.id,
    'dateTime': Timestamp.fromDate(dateTime),
  };
}
