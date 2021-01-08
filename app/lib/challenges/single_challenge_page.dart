import 'package:app/models/challenge.model.dart';
import 'package:app/models/user.model.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'challenge_date.dart';

class ProgressItem {
  DateTime date;
  List<User> users;
  bool completed;

  ProgressItem(this.date, this.users, this.completed);
}

class SingleChallengePage extends HookWidget {
  final Challenge challenge;

  const SingleChallengePage({Key key, @required this.challenge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProgressItem> items = [];

    return Container(
      color: Styles.appBackgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(challenge.name),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              var item = items[index];
              return ChallengeDate(
                  date: item.date,
                  toggled: item.completed,
                  onToggle: (value) {
                    print("on toggle $value");
                    items[index].completed = value;
                  });
            }, childCount: items.length),
          )
        ],
      ),
    );
  }
}
