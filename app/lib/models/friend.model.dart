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

  getInitials() {
    List<String> parts = name.split(' ').map((part) => part[0]).toList();

    if (parts.length > 2) {
      return "${parts[0]}${parts[1]}";
    }

    return parts.join('');
  }

  String toString() {
    return 'id=${this.id}, name=${this.name}, email=${this.email}, target=${this.targetWorkouts}';
  }
}
