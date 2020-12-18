import 'package:app/models/workout.model.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/cupertino.dart';

class WorkoutsCount extends StatelessWidget {
  final List<Workout> workouts;
  final int target;

  WorkoutsCount({this.workouts, this.target});

  int get percentageDone => (this.workouts.length / this.target * 100).round();

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.only(right: 30),
            child: Text('${this.percentageDone}%',
                textAlign: TextAlign.right, style: TextStyle(fontSize: 100)),
          ),
        ),
        Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Number of workouts so far this year'),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text('${this.workouts.length} / ${this.target}',
                    style: TextStyle(color: Styles.textColorLight)),
              ],
            ))
      ],
    );
  }
}
