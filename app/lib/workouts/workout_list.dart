import 'package:app/models/workout.model.dart';
import 'package:app/workouts/workout_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutList extends StatelessWidget {
  final List<Workout> workouts;

  WorkoutList(this.workouts);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      separatorBuilder: (ctx, index) => const Divider(
        height: 5.0,
        color: Colors.transparent,
      ),
      itemCount: workouts.length,
      itemBuilder: (BuildContext context, int index) {
        var workout = workouts[index];

        return WorkoutItem(workout);
      },
    );
  }
}
