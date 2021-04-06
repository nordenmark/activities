import 'package:app/models/workout.model.dart';
import 'package:app/workouts/workouts_service.dart';
import 'package:app/workouts/workouts_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final workoutsControllerProvider =
    StateNotifierProvider<WorkoutsController, WorkoutsState>(
        (ref) => WorkoutsController(ref.read(workoutsServiceProvider)));

final workoutsForYearProvider =
    Provider.family<List<Workout>, int>((ref, year) {
  final workouts = ref.watch(workoutsControllerProvider).workouts;

  return workouts.where((workout) => workout.date.year == year).toList();
});

class WorkoutsController extends StateNotifier<WorkoutsState> {
  final WorkoutsService workoutsService;

  WorkoutsController(this.workoutsService) : super(WorkoutsState.initial()) {
    _init();
  }

  _init() async {
    state = state.copyWith(isLoading: true);
    final workouts = await this.workoutsService.get();
    state = state.copyWith(workouts: workouts, isLoading: false);
  }

  Future<void> refresh() async {
    _init();
  }

  add(Workout workout) async {
    state = state.copyWith(isLoading: true);
    final createdWorkout = await this.workoutsService.add(workout);

    final List<Workout> list = [createdWorkout, ...state.workouts];
    list.sort((a, b) =>
        b.date.millisecondsSinceEpoch - a.date.millisecondsSinceEpoch);

    state = state.copyWith(workouts: list, isLoading: false);
  }

  update(int id, String activity, DateTime date) async {
    state = state.copyWith(isLoading: true);

    final updatedWorkout =
        await this.workoutsService.update(id, activity, date);

    var replaced = state.workouts.map((workout) {
      if (workout.id == id) {
        return updatedWorkout;
      } else {
        return workout;
      }
    }).toList();

    state = state.copyWith(workouts: replaced, isLoading: false);
  }

  void delete(int id) async {
    state = state.copyWith(isLoading: true);

    await this.workoutsService.delete(id);

    final clone = [...state.workouts];
    clone.removeWhere((workout) => workout.id == id);

    state = state.copyWith(workouts: clone, isLoading: false);
  }
}
