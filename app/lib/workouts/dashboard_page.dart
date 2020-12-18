import 'package:app/models/workout.model.dart';
import 'package:app/workouts/top_activities.dart';
import 'package:app/workouts/workouts_count.dart';
import 'package:flutter/widgets.dart';

import 'dashboard_card.dart';

class DashboardPage extends StatelessWidget {
  final List<Workout> workouts;

  DashboardPage({@required this.workouts});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DashboardCard(
            child: WorkoutsCount(workouts: this.workouts, target: 135)),
        Padding(padding: EdgeInsets.symmetric(vertical: 14)),
        DashboardCard(child: TopActivities(workouts: this.workouts)),
      ],
    );
  }
}
