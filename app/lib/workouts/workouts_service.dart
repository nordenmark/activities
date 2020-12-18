import 'package:app/models/workout.model.dart';
import 'package:app/root/http_service.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';

class WorkoutsService {
  final Dio _httpService;

  WorkoutsService(this._httpService);

  Future<List<Workout>> get() async {
    final workoutsJson = await this
        ._httpService
        .get('/workouts')
        .then((response) => response.data);

    final results = List<Map<String, dynamic>>.from(workoutsJson);

    final workouts = results
        .map((workoutData) => Workout.fromJson(workoutData))
        .toList(growable: true);

    return workouts;
  }

  Future<Workout> add(Workout workout) async {
    var data = workout.toJson();

    return this
        ._httpService
        .post('/workouts', data: data)
        .then((response) => Workout.fromJson(response.data));
  }

  Future<bool> delete(int id) async {
    return this._httpService.delete('/workouts/$id').then((_) => true);
  }

  Future<Workout> update(int id, String activity, DateTime date) async {
    var json = Workout(id: id, activity: activity, date: date).toJson();
    var data = {'date': json['date'], 'activity': json['activity']};

    return this
        ._httpService
        .put('/workouts/$id', data: data)
        .then((response) => Workout.fromJson(response.data));
  }
}

final workoutsServiceProvider = Provider<WorkoutsService>((ref) {
  final httpService = ref.read(httpServiceProvider);

  return WorkoutsService(httpService);
});
