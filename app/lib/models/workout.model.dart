import 'package:app/utils/icons.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

@immutable
class Workout {
  final int id;
  final DateTime date;
  final String activity;

  IconData get icon => IconHelper.iconFromActivity(activity);

  Workout({this.id, @required this.date, @required this.activity});

  factory Workout.fromJson(dynamic json) {
    return Workout(
      id: json['id'],
      date: DateTime.parse(json['date']),
      activity: json['activity'],
    );
  }

  dynamic toJson() {
    if (this.id != null) {
      return {
        'id': this.id,
        'date': DateFormat('y-MM-dd').format(this.date),
        'activity': this.activity,
      };
    }

    return {
      'date': DateFormat('y-MM-dd').format(this.date),
      'activity': this.activity,
    };
  }
}
