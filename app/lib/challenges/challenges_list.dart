import 'package:app/models/challenge.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'challenge_item.dart';

class ChallengesList extends StatelessWidget {
  final List<Challenge> challenges;

  ChallengesList(this.challenges);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        crossAxisSpacing: 40,
        children: List.generate(this.challenges.length,
            (index) => ChallengeItem(this.challenges[index])));
  }
}
