import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'add_challenge_form.dart';
import 'challenges_controller.dart';

class AddChallengePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);

    return Scaffold(
        appBar: AppBar(
          title: Text('ADD CHALLENGE'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: AddChallengeForm(
                isLoading: isLoading.value,
                onSubmit: (challenge) {
                  isLoading.value = true;
                  context.read(challengesControllerProvider).add(challenge);
                  isLoading.value = false;

                  Navigator.of(context).pop();
                })));
  }
}
