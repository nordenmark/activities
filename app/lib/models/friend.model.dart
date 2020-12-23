import 'package:flutter/widgets.dart';

@immutable
class Friend {
  final int id;
  final String email;
  final String name;
  final int workoutsCount;

  Friend({this.id, this.email, this.name, this.workoutsCount});

  factory Friend.fromJson(dynamic json) {
    return Friend(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      workoutsCount: json['workoutsCount'],
    );
  }
}
