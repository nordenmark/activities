import 'package:app/models/friend.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'friends_item.dart';

class FriendsList extends StatelessWidget {
  final List<Friend> friends;

  FriendsList(this.friends);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 5.0,
        color: Colors.transparent,
      ),
      itemCount: friends.length,
      itemBuilder: (BuildContext context, int index) {
        var friend = friends[index];

        return FriendItem(friend);
      },
    );
  }
}
