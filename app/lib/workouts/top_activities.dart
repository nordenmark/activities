import 'dart:math';

import 'package:app/models/workout.model.dart';
import 'package:app/utils/icons.dart';
import 'package:app/utils/styles.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopActivities extends StatelessWidget {
  final List<Workout> workouts;

  TopActivities({this.workouts});

  List<MapEntry<String, int>> _getTopActivities(List<Workout> workouts,
      {int count = 10}) {
    Map<String, int> countMap = Map();

    workouts.forEach((workout) {
      if (!countMap.containsKey(workout.activity)) {
        countMap[workout.activity] = 0;
      }

      countMap[workout.activity]++;
    });

    var list = countMap.entries.toList();

    list.sort((a, b) => b.value - a.value);

    return list.sublist(0, min(count, list.length));
  }

  int _getRoundedPercentage(int count, int totalCount) {
    return (count / totalCount * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, int>> activities =
        this._getTopActivities(this.workouts, count: 3);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Styles.overlayBgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText('Your top activities this year', type: TextType.H6),
            SizedBox(height: 4),
            Column(
                children: activities.map((entry) {
              return _activity(entry.value, entry.key);
            }).toList()),
          ],
        ));
  }

  Widget _activity(int count, String activity) {
    var percentage = _getRoundedPercentage(count, this.workouts.length);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          print(constraints);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Icon(IconHelper.iconFromActivity(activity),
                          size: 30, color: Styles.lightSlateGray),
                    ),
                    CustomText(activity,
                        type: TextType.SUBTITLE1,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                  flex: 1, child: CustomText('$count times ($percentage%)')),
            ],
          );
        },
      ),
    );
  }
}
