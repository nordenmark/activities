import 'package:app/models/workout.model.dart';
import 'package:app/workouts/workout_form.dart';
import 'package:app/workouts/workouts_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final activitiesProvider = Provider<Set<String>>((ref) {
  final workouts = ref.watch(workoutsForYearProvider(DateTime.now().year));

  return Set<String>.from(workouts.map((workout) => workout.activity));
});

class SingleWorkoutPage extends HookWidget {
  final Workout workout;

  SingleWorkoutPage({this.workout});

  @override
  Widget build(BuildContext context) {
    var activitySuggestions = useProvider(activitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(this.workout != null ? 'EDIT WORKOUT' : 'ADD WORKOUT'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: WorkoutForm(
              workout: this.workout,
              activitySuggestions: activitySuggestions,
              onSave: ({DateTime date, String activity}) {
                if (this.workout == null) {
                  context
                      .read(workoutsControllerProvider.notifier)
                      .add(Workout(activity: activity, date: date));
                } else {
                  context
                      .read(workoutsControllerProvider.notifier)
                      .update(this.workout.id, activity, date);
                }
                Navigator.of(context).pop();
              },
              onDelete: (Workout workout) {
                context
                    .read(workoutsControllerProvider.notifier)
                    .delete(workout.id);
                Navigator.of(context).pop();
              })),
    );
  }
}
