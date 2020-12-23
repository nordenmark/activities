import 'package:app/challenges/challenges_controller.dart';
import 'package:app/challenges/challenges_list.dart';
import 'package:app/widgets/spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/all.dart';

class ChallengesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(challengesControllerProvider.state).when(
        data: (challenges) => ChallengesList(challenges),
        loading: () => Center(child: Spinner(text: 'Loading challenges...')),
        error: (e, stack) => Text(e.toString()));
  }
}
