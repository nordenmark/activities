import 'package:app/models/workout.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WorkoutGraph extends HookWidget {
  final List<Workout> workouts;

  WorkoutGraph(this.workouts);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('WorkoutGraph'));
  }
}
