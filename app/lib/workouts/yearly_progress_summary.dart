import 'package:app/models/workout.model.dart';
import 'package:app/utils/styles.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/workouts/progress_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class YearlyProgressSummary extends StatelessWidget {
  final List<Workout> workouts;
  final int target;

  YearlyProgressSummary({this.workouts, this.target});

  @override
  Widget build(BuildContext context) {
    final String workoutsRemainingText = this._getWorkoutsRemainingText();
    final String timeRemainingText = this._getTimeRemainingText();
    final int percentRemaining =
        100 - (this.workouts.length / this.target * 100).round();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressCircle(
            width: 100,
            height: 100,
            baseColor: Styles.appDiscreteColor.withOpacity(0.4),
            progressPercent: this.workouts.length / this.target),
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText('Your workout summary', type: TextType.H6),
              SizedBox(height: 8),
              CustomText(
                '$percentRemaining% remaining',
                type: TextType.BODY_DISCRETE,
              ),
              CustomText(timeRemainingText, type: TextType.BODY_DISCRETE),
              CustomText(workoutsRemainingText, type: TextType.BODY_DISCRETE),
            ],
          ),
        ))
      ],
    );
  }

  String _getWorkoutsRemainingText() {
    final int remaining = this.target - this.workouts.length;

    if (remaining > 0) {
      return '$remaining workouts left to ${this.target}';
    } else if (remaining < 0) {
      return '$remaining workouts above target';
    } else {
      return 'You made it!';
    }
  }

  String _getTimeRemainingText() {
    final Jiffy endOfTheYear = Jiffy()..endOf(Units.YEAR);
    final Jiffy today = Jiffy()..startOf(Units.DAY);

    final differenceInDays = endOfTheYear.diff(today, Units.DAY);

    if (differenceInDays == 1) {
      return 'Today is the last day!';
    } else if (differenceInDays >= 60) {
      final differenceInMonths = endOfTheYear.diff(today, Units.MONTH);
      return '$differenceInMonths months left';
    }

    // Plus 1 to include today
    return '${differenceInDays + 1} days left';
  }
}
