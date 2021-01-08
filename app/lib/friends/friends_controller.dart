import 'package:app/friends/friends_service.dart';
import 'package:hooks_riverpod/all.dart';

import 'friends_state.dart';

final friendsControllerProvider =
    StateNotifierProvider<FriendsController>((ref) {
  final friendsService = ref.read(friendsServiceProvider);

  return FriendsController(friendsService);
});

class FriendsController extends StateNotifier<FriendsState> {
  final FriendsService friendsService;

  FriendsController(this.friendsService) : super(FriendsState.initial()) {
    _load();
  }

  Future<void> _load() async {
    state = state.copyWith(isLoading: true);
    final friends = await this.friendsService.get();
    state = state.copyWith(friends: friends, isLoading: false);
  }
}
