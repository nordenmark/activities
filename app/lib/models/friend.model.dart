import 'package:flutter/widgets.dart';

@immutable
class Friend {
  final int id;
  final String email;
  final String name;
  final int workoutsCount;
  final int targetWorkouts;

  Friend(
      {this.id,
      this.email,
      this.name,
      this.workoutsCount,
      this.targetWorkouts});

  factory Friend.fromJson(dynamic json) {
    return Friend(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      workoutsCount: json['workoutsCount'],
      targetWorkouts: json['targetWorkouts'],
    );
  }

  String toString() {
    return 'id=${this.id}, name=${this.name}, email=${this.email}, target=${this.targetWorkouts}';
  }
}
