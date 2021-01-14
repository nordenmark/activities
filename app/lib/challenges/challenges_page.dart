import 'package:app/challenges/challenges_controller.dart';
import 'package:app/challenges/challenges_list.dart';
import 'package:app/widgets/spinner.dart';
import 'package:app/widgets/tab_item.dart';
import 'package:app/widgets/tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'add_challenge_page.dart';

class ChallengesPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading = useProvider(challengesControllerProvider.state).isLoading;
    final challenges =
        useProvider(challengesControllerProvider.state).challenges;

    if (isLoading) {
      return Spinner(text: 'Loading challenges...');
    }

    return TabScreen(
        appBar: AppBar(title: Text('CHALLENGES')),
        tabItem: TabItem.challenges,
        fab: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddChallengePage()));
            }),
        body: ChallengesList(challenges));
  }
}
