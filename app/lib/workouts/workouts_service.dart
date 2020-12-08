import 'package:app/models/workout.model.dart';
import 'package:app/root/http_service.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';

class WorkoutsService {
  final Dio _httpService;

  WorkoutsService(this._httpService);

  Future<List<Workout>> get() async {
    try {
      final workoutsJson = await this
          ._httpService
          .get('/workouts')
          .then((response) => response.data);

      final results = List<Map<String, dynamic>>.from(workoutsJson);

      final workouts = results
          .map((workoutData) => Workout.fromJson(workoutData))
          .toList(growable: true);

      print("FETCHED ${workouts.length} workouts");

      return workouts;
    } on DioError catch (e) {
      print("Got DioError in workoutService.get(), returning empty array");
      print(e.type.toString());
      return [];
    }
  }
}

final workoutsServiceProvider = Provider<WorkoutsService>((ref) {
  final httpService = ref.read(httpServiceProvider);

  return WorkoutsService(httpService);
});
