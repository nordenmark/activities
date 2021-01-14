import 'package:app/models/workout.model.dart';
import 'package:flutter/material.dart';

class WorkoutActivities extends StatelessWidget {
  final List<Workout> workouts;

  WorkoutActivities(this.workouts);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('WorkoutActivities'));
  }
}
