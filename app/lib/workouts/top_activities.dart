import 'package:app/models/workout.model.dart';
import 'package:app/utils/styles.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';

class TopActivities extends StatelessWidget {
  final List<Workout> workouts;

  TopActivities({this.workouts});

  List<String> _getTopActivities(List<Workout> workouts) {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> activities =
        this._getTopActivities(this.workouts).asMap().entries.map((entry) {
      int index = entry.key;
      String activity = entry.value;
      return _activity(index, activity);
    }).toList();

    return Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
        color: Styles.overlayBgColor,
        child: Row(
          children: [
            CustomText('Your top activities', type: TextType.H5),
            Column(children: activities),
          ],
        ));
  }

  Widget _activity(int index, String activity) {
    return Row(children: [
      Text((index + 1).toString()),
      Text(activity),
    ]);
  }
}
