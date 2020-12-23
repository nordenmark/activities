import 'package:app/friends/friends_service.dart';
import 'package:app/models/friend.model.dart';
import 'package:hooks_riverpod/all.dart';

final friendsControllerProvider =
    StateNotifierProvider.autoDispose<FriendsController>((ref) {
  ref.maintainState = true;

  final friendsService = ref.read(friendsServiceProvider);

  return FriendsController(friendsService);
});

class FriendsController extends StateNotifier<AsyncValue<List<Friend>>> {
  final FriendsService friendsService;

  FriendsController(this.friendsService) : super(AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => this.friendsService.get());
  }
}
