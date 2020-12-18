import 'package:app/models/user.model.dart';
import 'package:app/widgets/circle_initials.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SettingsUserCard extends StatelessWidget {
  final User user;

  SettingsUserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: CircleInitials(_getInitials(user.name)),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(user.name, type: TextType.H5),
                    CustomText(user.email, type: TextType.BODY2)
                  ]),
            )
          ],
        ));
  }

  _getInitials(String name) {
    List<String> parts = name.split(' ').map((part) => part[0]).toList();

    if (parts.length > 2) {
      return "${parts[0]}${parts[1]}";
    }

    return parts.join('');
  }
}
