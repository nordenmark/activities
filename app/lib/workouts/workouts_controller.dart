import 'package:app/models/workout.model.dart';
import 'package:app/workouts/workouts_state.dart';
import 'package:hooks_riverpod/all.dart';

final workoutsControllerProvider =
    StateNotifierProvider<WorkoutsController>((ref) {
  return WorkoutsController();
});

class WorkoutsController extends StateNotifier<WorkoutsState> {
  WorkoutsController([WorkoutsState state])
      : super(state ?? WorkoutsState.initial());

  void setWorkouts(List<Workout> workouts) {
    print('setting ${workouts.length} workouts in state');
    this.state = this.state.copyWith(workouts: workouts);
  }
}
