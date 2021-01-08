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
    final int daysElapsed = this._getDaysElapsed();
    final int targetWorkouts = this._getTargetWorkouts(daysElapsed);
    final int daysRemaining = this._getDaysRemaining();
    final double progressPercent = this._getProgressPercent();

    String encouragementText = '';
    Color progressColor;

    if (this.workouts.length > targetWorkouts) {
      encouragementText =
          'You are ahead by ${this.workouts.length - targetWorkouts}, great job!';
      progressColor = Colors.green;
    } else if (this.workouts.length == targetWorkouts) {
      encouragementText = 'You are up to speed, good job!';
      progressColor = Colors.orange;
    } else {
      encouragementText =
          'You need ${targetWorkouts - this.workouts.length} more to be up to speed, keep working out!';
      progressColor = Colors.red;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressCircle(
            width: 100,
            height: 100,
            baseColor: Styles.appDiscreteColor.withOpacity(0.4),
            progressColor: progressColor,
            progressPercent: progressPercent),
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText('Your workout summary', type: TextType.H6),
              SizedBox(height: 8),
              RichText(
                  text: TextSpan(style: Styles.discreteStyle, children: [
                TextSpan(text: 'We are on day '),
                TextSpan(text: '$daysElapsed, ', style: Styles.baseStyle),
                TextSpan(text: '$daysRemaining', style: Styles.baseStyle),
                TextSpan(text: ' days remain and you should be at '),
                TextSpan(text: '$targetWorkouts', style: Styles.baseStyle),
                TextSpan(text: ' workouts.'),
              ])),
              SizedBox(height: 8),
              RichText(
                  text: TextSpan(style: Styles.discreteStyle, children: [
                TextSpan(text: 'You are at '),
                TextSpan(
                    text: '${this.workouts.length}', style: Styles.baseStyle),
                TextSpan(text: '.'),
              ])),
              SizedBox(height: 8),
              CustomText(encouragementText),
            ],
          ),
        ))
      ],
    );
  }

  double _getProgressPercent() {
    var progress = this.workouts.length / this.target;

    if (progress.isNaN) {
      return 0;
    }

    return progress;
  }

  int _getTargetWorkouts(int daysElapsed) {
    final int numberOfDays = Jiffy().isLeapYear ? 366 : 365;
    final double workoutsPerDay = this.target / numberOfDays;

    return (workoutsPerDay * daysElapsed).floor();
  }

  int _getDaysElapsed() {
    return Jiffy().dayOfYear;
  }

  int _getDaysRemaining() {
    final Jiffy endOfTheYear = Jiffy()..endOf(Units.YEAR);
    final Jiffy today = Jiffy()..startOf(Units.DAY);

    // Include today
    return endOfTheYear.diff(today, Units.DAY) + 1;
  }
}
