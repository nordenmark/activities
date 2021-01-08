import 'package:app/widgets/spinner.dart';
import 'package:app/workouts/workout_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/all.dart';

import 'workouts_controller.dart';

class WorkoutsPage extends ConsumerWidget {
  const WorkoutsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isLoading = watch(workoutsControllerProvider.state).isLoading;
    final workouts = watch(workoutsControllerProvider.state).workouts;

    if (isLoading) {
      return Spinner(text: 'Loading workouts...');
    }

    return RefreshIndicator(
      onRefresh: () {
        return context.read(workoutsControllerProvider).refresh();
      },
      child: WorkoutList(workouts),
    );
  }
}
