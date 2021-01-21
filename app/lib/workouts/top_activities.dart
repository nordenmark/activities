import 'package:app/models/workout.model.dart';
import 'package:app/utils/icons.dart';
import 'package:app/utils/styles.dart';
import 'package:app/utils/workouts.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopActivities extends StatelessWidget {
  final List<Workout> workouts;

  TopActivities({this.workouts});

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, int>> activities =
        WorkoutHelpers.getCountPerActivity(this.workouts, count: 3);

    List<Widget> children = activities
        .map((entry) => TopActivity(
            count: entry.value,
            title: entry.key,
            totalCount: this.workouts.length))
        .toList();

    return Container(
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Styles.overlayBgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText('Your top activities this year', type: TextType.H7),
            SizedBox(height: 8),
            Column(children: children),
          ],
        ));
  }
}

class TopActivity extends StatelessWidget {
  final String title;
  final int count;
  final int totalCount;

  const TopActivity({Key key, this.title, this.count, this.totalCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var percentage = (this.count / this.totalCount * 100).round();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(IconHelper.iconFromActivity(this.title),
                      size: 30, color: Styles.lightSlateGray),
                ),
                CustomText(this.title,
                    type: TextType.SUBTITLE1,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(flex: 1, child: CustomText('$count times ($percentage%)')),
        ],
      ),
    );
  }
}
