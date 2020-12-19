import 'package:app/models/workout.model.dart';
import 'package:app/workouts/workouts_service.dart';
import 'package:hooks_riverpod/all.dart';

final workoutsControllerProvider =
    StateNotifierProvider.autoDispose<WorkoutsController>((ref) {
  ref.maintainState = true;

  final workoutsService = ref.read(workoutsServiceProvider);

  return WorkoutsController(workoutsService);
});

class WorkoutsController extends StateNotifier<AsyncValue<List<Workout>>> {
  final WorkoutsService workoutsService;

  WorkoutsController(this.workoutsService) : super(AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => this.workoutsService.get());
  }

  void add(Workout workout) async {
    // To keep a reference to the list while we set the state to loading
    var list = state.data.value;
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final createdWorkout = await this.workoutsService.add(workout);

      return [createdWorkout, ...list];
    });
  }

  void update(int id, String activity, DateTime date) async {
    // To keep a reference to the list while we set the state to loading
    var list = state.data.value;
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final updatedWorkout =
          await this.workoutsService.update(id, activity, date);

      var replaced = list.map((workout) {
        if (workout.id == id) {
          return updatedWorkout;
        } else {
          return workout;
        }
      }).toList();

      return replaced;
    });
  }

  void delete(int id) async {
    // To keep a reference to the list while we set the state to loading
    var list = state.data.value;
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await this.workoutsService.delete(id);
      var clone = [...list];
      clone.removeWhere((workout) => workout.id == id);
      return clone;
    });
  }
}
