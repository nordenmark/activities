import 'package:app/models/workout.model.dart';
import 'package:flutter/widgets.dart';

class DetailsPage extends StatelessWidget {
  final List<Workout> workouts;

  const DetailsPage({Key key, this.workouts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(workouts[index].activity);
        });
  }
}
