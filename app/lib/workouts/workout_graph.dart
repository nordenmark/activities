import 'package:app/models/workout.model.dart';
import 'package:app/utils/workouts.dart';
import 'package:app/widgets/bar_chart.dart';
import 'package:app/widgets/spinner.dart';
import 'package:app/widgets/year_selector.dart';
import 'package:app/workouts/workouts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

final selectedYearProvider = StateProvider<int>((ref) => DateTime.now().year);

class WorkoutGraph extends HookWidget {
  WorkoutGraph();

  @override
  Widget build(BuildContext context) {
    final selectedYear = useProvider(selectedYearProvider).state;
    final List<Workout> workouts =
        useProvider(workoutsForYearProvider(selectedYear));
    final countPerMonth = WorkoutHelpers.getCountPerMonth(workouts);
    final entries = this._getBarChartEntries(countPerMonth);

    final isLoading = useProvider(workoutsControllerProvider.state).isLoading;

    if (isLoading) {
      return Center(child: Spinner(text: 'Loading workouts...'));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          YearSelector(
            selectedYear: selectedYear,
            onSelected: (int year) {
              context.read(selectedYearProvider).state = year;
            },
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: BarChart(height: 300, entries: entries)),
        ],
      ),
    );
  }

  List<BarChartEntry> _getBarChartEntries(Map<String, int> map) {
    return map.entries
        .map((entry) => BarChartEntry(entry.key, entry.value))
        .toList();
  }
}
