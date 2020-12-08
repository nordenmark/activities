import 'package:app/utils/icons.dart';
import 'package:flutter/widgets.dart';

@immutable
class Workout {
  final int id;
  final DateTime date;
  final String activity;

  IconData get icon => IconHelper.iconFromActivity(activity);

  Workout({this.id, this.date, this.activity});

  factory Workout.fromJson(dynamic json) {
    return Workout(
      id: json['id'],
      date: DateTime.parse(json['date']),
      activity: json['activity'],
    );
  }
}
