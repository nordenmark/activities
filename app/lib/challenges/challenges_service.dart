import 'package:app/models/challenge.model.dart';
import 'package:app/root/http_service.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';

final challengesServiceProvider = Provider<ChallengesService>((ref) {
  final httpService = ref.read(httpServiceProvider);

  return ChallengesService(httpService);
});

class ChallengesService {
  final Dio _httpService;

  ChallengesService(this._httpService);

  Future<List<Challenge>> get() async {
    final json = await this
        ._httpService
        .get('/challenges')
        .then((response) => response.data);

    final results = List<Map<String, dynamic>>.from(json);

    final challenges =
        results.map((data) => Challenge.fromJson(data)).toList(growable: true);

    return challenges;
  }

  Future<Challenge> add(Challenge challenge) async {
    var data = challenge.toJson();

    return this
        ._httpService
        .post('/challenges', data: data)
        .then((response) => Challenge.fromJson(response.data));
  }

  toggleProgress(Challenge challenge, bool completed, DateTime date) async {
    var data = {
      'completed': completed,
      'date': DateFormat('y-MM-dd').format(date),
    };

    return this
        ._httpService
        .post('/challenges/${challenge.id}/toggle-progress', data: data)
        .then((response) => true);
  }
}
