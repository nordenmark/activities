import 'package:app/models/friend.model.dart';
import 'package:app/widgets/user_card.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final Friend friend;

  FriendItem(this.friend);

  @override
  Widget build(BuildContext context) {
    return UserCard(
        user: this.friend,
        onTap: () {
          print("tap friend");
        });
  }
}
