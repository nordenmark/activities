import 'package:app/models/workout.model.dart';
import 'package:app/utils/styles.dart';
import 'package:app/workouts/single_workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutItem extends StatelessWidget {
  final Workout workout;

  WorkoutItem(this.workout);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        color: Styles.white,
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      SingleWorkoutPage(workout: this.workout)));
            },
            child: Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(workout.activity,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .apply(fontWeightDelta: 2)),
                                Text(DateFormat('y-MM-dd').format(workout.date),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .apply(color: Styles.lightSlateGray))
                              ]),
                        )),
                    Container(
                      child: Icon(workout.icon,
                          size: 36, color: Styles.lightSlateGray),
                    ),
                  ],
                ))));
  }
}
