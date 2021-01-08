import 'package:app/challenges/challenges_controller.dart';
import 'package:app/challenges/challenges_list.dart';
import 'package:app/widgets/spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/all.dart';

class ChallengesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isLoading = watch(challengesControllerProvider.state).isLoading;
    final challenges = watch(challengesControllerProvider.state).challenges;

    if (isLoading) {
      return Spinner(text: 'Loading challenges...');
    }

    return ChallengesList(challenges);
  }
}
