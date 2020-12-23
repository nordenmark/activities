import 'package:app/models/challenge.model.dart';
import 'package:hooks_riverpod/all.dart';

import 'challenges_service.dart';

final challengesControllerProvider =
    StateNotifierProvider.autoDispose<ChallengesController>((ref) {
  ref.maintainState = true;

  final challengesService = ref.read(challengesServiceProvider);

  return ChallengesController(challengesService);
});

class ChallengesController extends StateNotifier<AsyncValue<List<Challenge>>> {
  final ChallengesService challengesService;

  ChallengesController(this.challengesService) : super(AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => this.challengesService.get());
  }
}
