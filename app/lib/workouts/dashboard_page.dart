import 'package:app/models/workout.model.dart';
import 'package:app/widgets/spinner.dart';
import 'package:app/workouts/top_activities.dart';
import 'package:app/workouts/workouts_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app/workouts/workouts_controller.dart';
import 'package:hooks_riverpod/all.dart';

import 'dashboard_card.dart';

class DashboardPage extends HookWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var workouts = useProvider(workoutsControllerProvider.state);

    return workouts.when(
      loading: () => Center(child: Spinner()),
      error: (e, stack) => Text(e.toString()),
      data: (workouts) => body(workouts),
    );
  }

  Widget body(List<Workout> workouts) {
    List<Widget> children = [
      WorkoutsCount(workouts: workouts, target: 135),
      TopActivities(workouts: workouts)
    ];

    return ListView.separated(
      padding: EdgeInsets.all(8),
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 15.0, color: Colors.transparent),
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) {
        var child = children[index];

        return DashboardCard(child: child);
      },
    );
  }
}
