import 'package:app/auth/auth_controller.dart';
import 'package:app/friends/friends_controller.dart';
import 'package:app/models/workout.model.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import 'horizontal_bar_chart.dart';

class FriendsProgress extends HookWidget {
  final List<Workout> workouts;

  FriendsProgress({this.workouts});

  @override
  Widget build(BuildContext context) {
    var friends = useProvider(friendsControllerProvider).friends;
    var user = useProvider(authControllerProvider).user;

    List<BarChartEntry> entries = [];

    // Me
    // @TODO get target from settings
    int diff = this.workouts.length - this._getTargetForToday(156);
    entries.add(BarChartEntry(user.name, diff));

    // Friends
    friends.forEach((friend) {
      int diff =
          friend.workoutsCount - this._getTargetForToday(friend.targetWorkouts);
      entries.add(BarChartEntry(friend.name, diff));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText('You and your friends', type: TextType.H7),
        SizedBox(height: 12),
        HorizontalBarChart(entries),
      ],
    );
  }

  // @TODO extract into a separate class
  int _getTargetForToday(int targetWorkouts) {
    final int daysElapsed = Jiffy().dayOfYear;
    final int numberOfDays = Jiffy().isLeapYear ? 366 : 365;
    final double workoutsPerDay = targetWorkouts / numberOfDays;

    return (workoutsPerDay * daysElapsed).floor();
  }
}
