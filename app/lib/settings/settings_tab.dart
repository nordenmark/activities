import 'package:app/auth/auth_controller.dart';
import 'package:app/settings/settings_group.dart';
import 'package:app/settings/settings_item.dart';
import 'package:app/settings/settings_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SettingsTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authController = useProvider(authControllerProvider);
    final authState = useProvider(authControllerProvider.state);

    return CustomScrollView(slivers: <Widget>[
      CupertinoSliverNavigationBar(largeTitle: Text('Settings')),
      SliverList(
        delegate: SliverChildListDelegate([
          SettingsUserCard(authState.user),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          SettingsGroup(
            [
              SettingsItem(
                  label: 'Log out',
                  onPress: () async {
                    return authController.logout();
                  },
                  icon: CupertinoIcons.signature),
            ],
          )
        ]),
      )
    ]);
  }
}
