import 'package:hive/hive.dart';
part 'user.g.dart';
@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  String image;
  @HiveField(5)
  String lat;
  @HiveField(6)
  String long;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.image,
      required this.lat,
      required this.long});

  factory User.fromJson(Map<String, dynamic> json, String id) {
    return User(
      id: id,
      name: json['name'],
      email: json['email'],
      password: json['password'],
      image: json['image'],
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'image': image,
      'lat': lat,
      'long': long
    };
  }
}
