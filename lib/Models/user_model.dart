class UserModel {
  String id;
  String name;
  String email;
  List<String> favouriteEvents;

  UserModel({
    this.id = '',
    required this.name,
    required this.email,
    required this.favouriteEvents,
  });

  UserModel.fromJson(Map<String, dynamic> json) : this(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    favouriteEvents: (json['favouriteEvents'] as List).cast<String>(),
  );

  Map<String, dynamic> toJSON() => {
    'id': id,
    'name': name,
    'email': email,
    'favouriteEvents': favouriteEvents,
  };
}
