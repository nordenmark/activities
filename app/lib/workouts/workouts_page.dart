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
    return watch(workoutsControllerProvider.state).when(
        data: (workouts) => WorkoutList(workouts),
        loading: () => Center(child: Spinner()),
        error: (e, stack) => Text(e.toString()));
  }
}
