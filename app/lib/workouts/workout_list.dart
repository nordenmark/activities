import 'package:app/models/workout.model.dart';
import 'package:app/widgets/spinner.dart';
import 'package:app/workouts/workout_item.dart';
import 'package:app/workouts/workouts_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class WorkoutList extends HookWidget {
  WorkoutList();

  @override
  Widget build(BuildContext context) {
    final List<Workout> workouts =
        useProvider(workoutsForYearProvider(DateTime.now().year));
    final isLoading = useProvider(workoutsControllerProvider.state).isLoading;

    if (isLoading) {
      return Center(child: Spinner(text: 'Loading workouts...'));
    }

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
