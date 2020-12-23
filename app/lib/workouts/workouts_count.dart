import 'package:app/models/workout.model.dart';
import 'package:app/utils/styles.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutsCount extends StatelessWidget {
  final List<Workout> workouts;
  final int target;

  WorkoutsCount({this.workouts, this.target});

  int get percentageDone => (this.workouts.length / this.target * 100).round();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Text('${this.percentageDone}%',
                textAlign: TextAlign.right, style: TextStyle(fontSize: 80)),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText('Number of workouts so far this year',
                      type: TextType.SUBTITLE2),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text('${this.workouts.length} / ${this.target}',
                      style: TextStyle(color: Styles.appDiscreteColor)),
                ],
              ),
            ))
      ],
    );
  }
}
