import 'package:app/friends/friends_controller.dart';
import 'package:app/models/workout.model.dart';
import 'package:app/widgets/spinner.dart';
import 'package:app/workouts/friends_progress.dart';
import 'package:app/workouts/top_activities.dart';
import 'package:app/workouts/yearly_progress_summary.dart';
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
    final workouts = useProvider(workoutsControllerProvider.state).workouts;
    final isLoadingWorkouts =
        useProvider(workoutsControllerProvider.state).isLoading;

    if (isLoadingWorkouts) {
      return Spinner(text: 'Loading dashboard...');
    }

    return RefreshIndicator(
      onRefresh: () async {
        await context.read(friendsControllerProvider).refresh();
        await context.read(workoutsControllerProvider).refresh();
      },
      child: body(workouts),
    );
  }

  Widget body(List<Workout> workouts) {
    List<Widget> children = [
      // @TODO get target from settings
      YearlyProgressSummary(workouts: workouts, target: 156),
      FriendsProgress(),
      TopActivities(workouts: workouts),
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
