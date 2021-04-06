import 'package:app/challenges/challenges_state.dart';
import 'package:app/models/challenge.model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'challenges_service.dart';

final challengesControllerProvider =
    StateNotifierProvider<ChallengesController, ChallengesState>(
        (ref) => ChallengesController(ref.read(challengesServiceProvider)));

class ChallengesController extends StateNotifier<ChallengesState> {
  final ChallengesService challengesService;

  ChallengesController(this.challengesService)
      : super(ChallengesState.initial()) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    final challenges = await this.challengesService.get();
    state = state.copyWith(challenges: challenges, isLoading: false);
  }

  Future<void> refresh() async {
    return this._init();
  }

  void add(Challenge challenge) async {
    state = state.copyWith(isLoading: true);
    final createdChallenge = await this.challengesService.add(challenge);
    state = state.copyWith(
        challenges: [createdChallenge, ...state.challenges], isLoading: false);
  }
}
