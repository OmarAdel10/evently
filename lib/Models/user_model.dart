class UserModel {
  String id;
  String name;
  String email;
  String? imageUrl;
  List<String> favouriteEventsIds;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl,
    required this.favouriteEventsIds,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          imageUrl: json['imageUrl'],
          favouriteEventsIds:
              (json['favouriteEventsIds'] as List).cast<String>(),
        );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'name': name,
        'email': email,
        'imageUrl': imageUrl,
        'favouriteEventsIds': favouriteEventsIds,
      };
}

