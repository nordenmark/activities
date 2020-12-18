import 'package:app/models/workout.model.dart';
import 'package:app/workouts/workout_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WorkoutsPage extends HookWidget {
  final List<Workout> workouts;

  const WorkoutsPage({Key key, this.workouts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WorkoutList(this.workouts);
  }
}
