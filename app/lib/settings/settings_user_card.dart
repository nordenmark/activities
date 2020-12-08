import 'package:app/models/user.model.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';

class SettingsUserCard extends StatelessWidget {
  final User user;

  SettingsUserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CupertinoColors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CircularProfileAvatar(
              'assets/images/appicon.png',
              showInitialTextAbovePicture: true,
              foregroundColor: CupertinoColors.systemBlue,
              initialsText: Text(
                _getInitials(user.name),
                style: TextStyle(fontSize: 20, color: CupertinoColors.white),
              ),
              radius: 20,
            ),
            Expanded(
              child: Column(children: [Text(user.name), Text(user.email)]),
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
