import 'package:app/models/friend.model.dart';
import 'package:app/root/http_service.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final friendsServiceProvider = Provider<FriendsService>((ref) {
  final httpService = ref.read(httpServiceProvider);

  return FriendsService(httpService);
});

class FriendsService {
  final Dio _httpService;

  FriendsService(this._httpService);

  Future<List<Friend>> get() async {
    final json = await this
        ._httpService
        .get('/friends')
        .then((response) => response.data);

    final results = List<Map<String, dynamic>>.from(json);

    final friends = results
        .map((workoutData) => Friend.fromJson(workoutData))
        .toList(growable: true);

    print("Friends: $friends");

    return friends;
  }
}
