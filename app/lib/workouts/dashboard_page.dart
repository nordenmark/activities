import 'package:app/models/workout.model.dart';
import 'package:flutter/widgets.dart';

class DashboardPage extends StatelessWidget {
  final List<Workout> workouts;

  DashboardPage({this.workouts});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Dashboard'));
  }
}
