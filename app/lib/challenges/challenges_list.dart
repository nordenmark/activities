import 'package:app/challenges/single_challenge_page.dart';
import 'package:app/models/challenge.model.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'challenge_item.dart';

class ChallengesList extends StatelessWidget {
  final List<Challenge> challenges;

  ChallengesList(this.challenges);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (BuildContext context, int index) {
        var challenge = this.challenges[index];

        return Card(
            margin: EdgeInsets.zero,
            color: Styles.overlayBgColor,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SingleChallengePage(challenge: challenge)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ChallengeItem(challenge),
                )));
      },
      itemCount: this.challenges.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 15.0, color: Colors.transparent),
    );
  }
}
