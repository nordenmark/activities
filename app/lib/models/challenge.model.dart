import 'package:flutter/widgets.dart';

@immutable
class Challenge {
  final int id;
  final String name;
  final DateTime fromDate;
  final DateTime toDate;

  Challenge({this.id, this.name, this.fromDate, this.toDate});

  factory Challenge.fromJson(dynamic json) {
    return Challenge(
      id: json['id'],
      name: json['name'],
      fromDate: DateTime.parse(json['fromDate']),
      toDate: DateTime.parse(json['toDate']),
    );
  }
}
