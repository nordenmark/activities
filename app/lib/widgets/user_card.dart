import 'package:app/models/friend.model.dart';
import 'package:app/models/user.model.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class UserCard extends StatelessWidget {
  final dynamic user;
  final Function onTap;

  const UserCard({Key key, this.user, this.onTap})
      : assert(user is User || user is Friend),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        color: Styles.white,
        child: InkWell(
            onTap: this.onTap,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(child: Text(user.getInitials())),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        this.user.name,
                        type: TextType.BODY,
                      ),
                      CustomText(this.user.email, type: TextType.BODY_DISCRETE),
                    ],
                  ),
                ],
              ),
            )));
  }
}
