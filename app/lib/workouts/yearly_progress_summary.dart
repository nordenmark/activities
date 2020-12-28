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
            progressPercent: this.workouts.length / targetWorkouts),
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

  int _getTargetWorkouts(int daysElapsed) {
    final double workoutsPerDay = this.target / 365;

    return (workoutsPerDay * daysElapsed).round();
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

  String _getPercentRemainingText() {
    final int percentRemaining =
        100 - (this.workouts.length / this.target * 100).round();

    if (percentRemaining > 0) {
      return '$percentRemaining% remaining';
    } else {
      return '0% remaining';
    }
  }

  String _getWorkoutsRemainingText() {
    final int remaining = this.target - this.workouts.length;

    if (remaining > 0) {
      return '$remaining workouts left to ${this.target}';
    } else if (remaining < 0) {
      return '${-1 * remaining} workouts above target';
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
