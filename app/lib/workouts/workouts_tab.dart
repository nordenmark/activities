import 'package:app/models/workout.model.dart';
import 'package:app/root/spinner.dart';
import 'package:app/widgets/swipe_pages.dart';
import 'package:app/workouts/stats_page.dart';
import 'package:app/workouts/workouts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

import 'dashboard_page.dart';
import 'details_page.dart';

final workoutsFutureProvider = FutureProvider.autoDispose<List<Workout>>((ref) {
  ref.maintainState = true;

  final workoutsService = ref.read(workoutsServiceProvider);

  return workoutsService.get();
});

class WorkoutsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(workoutsFutureProvider).when(
      data: (workouts) {
        return SwipePages([
          SwipePage('Dashboard', DashboardPage(workouts: workouts)),
          SwipePage('Details', DetailsPage(workouts: workouts)),
          SwipePage('Stats', StatsPage())
        ]);
      },
      loading: () => Center(child: Spinner(text: 'Loading workouts...')),
      error: (e, stack) => Center(child: Text('Error ${e.toString()}')),
    );
  }
}
