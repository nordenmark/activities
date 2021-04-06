import 'package:app/models/workout.model.dart';
import 'package:app/utils/icons.dart';
import 'package:app/utils/workouts.dart';
import 'package:app/widgets/chart_legend.dart';
import 'package:app/widgets/donut_chart.dart';
import 'package:app/widgets/spinner.dart';
import 'package:app/widgets/year_selector.dart';
import 'package:app/workouts/workouts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedYearProvider = StateProvider<int>((ref) => DateTime.now().year);

class WorkoutActivities extends HookWidget {
  WorkoutActivities();

  @override
  Widget build(BuildContext context) {
    final selectedYear = useProvider(selectedYearProvider).state;
    final List<Workout> workouts =
        useProvider(workoutsForYearProvider(selectedYear));
    final isLoading = useProvider(workoutsControllerProvider).isLoading;

    if (isLoading) {
      return Center(child: Spinner(text: 'Loading workouts...'));
    }

    List<MapEntry<String, int>> activities =
        WorkoutHelpers.getCountPerActivity(workouts);

    List<ChartEntry> entries = activities
        .map((entry) => ChartEntry(entry.key, entry.value.toDouble(),
            IconHelper.iconFromActivity(entry.key)))
        .toList();

    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: YearSelector(
          selectedYear: selectedYear,
          onSelected: (int year) {
            context.read(selectedYearProvider).state = year;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(100.0),
        child: DonutChart(entries: entries),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
        child: ChartLegend(
          entries: entries,
        ),
      )
    ]);
  }
}
