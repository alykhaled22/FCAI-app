import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String? gender;
  @HiveField(5)
  final String? level;
  @HiveField(6)
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.gender,
    this.level,
    this.imageUrl,
  });
}
