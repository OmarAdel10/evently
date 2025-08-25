import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyy/Models/category_model.dart';

class EventModel {
  String id;
  String userId;
  String userCreatedThisEventName;
  String userCreatedThisEventEmail;
  String title;
  String description;
  CategoryModel category;
  DateTime dateTime;

  EventModel({
    this.id = '',
    required this.userId,
    required this.userCreatedThisEventName,
    required this.userCreatedThisEventEmail,
    required this.title,
    required this.description,
    required this.category,
    required this.dateTime,
  });

  EventModel.fromJSON(Map<String, dynamic> json) : this(
    id: json['id'],
    userId: json['userId'],
    userCreatedThisEventName: json['userCreatedThisEventName'],
    userCreatedThisEventEmail: json['userCreatedThisEventEmail'],
    title: json['title'],
    description: json['description'],
    category: CategoryModel.categories.firstWhere((category) => category.id == json['category']),
    dateTime: (json['dateTime'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJSON() => {
    'id': id,
    'userId': userId,
    'userCreatedThisEventName': userCreatedThisEventName,
    'userCreatedThisEventEmail': userCreatedThisEventEmail,
    'title': title,
    'description': description,
    'category': category.id,
    'dateTime': Timestamp.fromDate(dateTime),
  };
}
