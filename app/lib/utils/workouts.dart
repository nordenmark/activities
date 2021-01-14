import 'package:app/models/workout.model.dart';
import 'package:app/utils/dates.dart';

class WorkoutHelpers {
  static Map<String, int> getCountPerMonth(List<Workout> workouts) {
    Map<String, int> map = Map();

    // Sort the workouts by date asc to get jan first
    workouts.sort((a, b) => a.date.month - b.date.month);

    workouts.forEach((workout) {
      var month = DateHelper.getMonthFromString(workout.date);
      if (!map.containsKey(month)) {
        map[month] = 0;
      }

      map[month]++;
    });

    return map;
  }
}
