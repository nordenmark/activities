import 'package:app/models/friend.model.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final Friend friend;

  FriendItem(this.friend);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        color: Styles.white,
        child: InkWell(
            onTap: () {
              print("on tap");
            },
            child: Container(
              child: Text(this.friend.email),
            )));
  }
}
