import 'package:app/models/challenge.model.dart';
import 'package:app/utils/styles.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/workouts/progress_circle.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class ChallengeItem extends StatelessWidget {
  final Challenge challenge;

  const ChallengeItem(this.challenge);

  @override
  Widget build(BuildContext context) {
    final String timeRemaining = _getTimeRemainingText(this.challenge.toDate);

    return Row(
      children: [
        ProgressCircle(
          progressPercent: 0.5,
          width: 80,
          height: 80,
          baseColor: Styles.appDiscreteColor.withOpacity(0.4),
          progressColor: this.challenge.id % 2 == 0 ? Colors.green : Colors.red,
        ),
        SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                challenge.name,
                type: TextType.H7,
              ),
              CustomText(timeRemaining),
            ],
          ),
        ),
      ],
    );
  }

  String _getTimeRemainingText(DateTime toDate) {
    final endOfLastDay = Jiffy(toDate)..endOf(Units.DAY);
    final daysRemaining = endOfLastDay.diff(DateTime.now(), Units.DAY) + 1;

    return '$daysRemaining days left';
  }
}
