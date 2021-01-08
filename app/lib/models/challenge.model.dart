import 'package:app/models/user.model.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

// @TODO how do we use this?
class Progress {
  final DateTime date;
  final User user;

  Progress({this.date, this.user});

  factory Progress.fromJson(dynamic json) {
    return Progress(
      date: DateTime.parse(json['date']),
      user: User.fromJson(json['user']),
    );
  }

  @override
  String toString() {
    return "date=$date,user=$user";
  }
}

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

  dynamic toJson() {
    dynamic json = {
      'fromDate': DateFormat('y-MM-dd').format(this.fromDate),
      'toDate': DateFormat('y-MM-dd').format(this.toDate),
      'name': this.name,
    };

    if (this.id != null) {
      json['id'] = this.id;
    }

    return json;
  }
}
