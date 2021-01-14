import 'package:app/auth/auth_controller.dart';
import 'package:app/friends/friends_screen.dart';
import 'package:app/settings/settings_group.dart';
import 'package:app/settings/settings_item.dart';
import 'package:app/settings/settings_user_card.dart';
import 'package:app/widgets/tab_item.dart';
import 'package:app/widgets/tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hooks_riverpod/all.dart';

class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authController = useProvider(authControllerProvider);
    final authState = useProvider(authControllerProvider.state);

    List<Widget> children = [
      SettingsUserCard(authState.user),
      SettingsGroup(
        [
          SettingsItem(
            label: 'Friends',
            onPress: () {
              return Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FriendsScreen()));
            },
            icon: FlutterIcons.users_ent,
          ),
          SettingsItem(
              label: 'Log out',
              onPress: () async {
                return authController.logout();
              },
              icon: FlutterIcons.door_closed_mco),
        ],
      )
    ];

    return TabScreen(
        appBar: AppBar(title: Text('SETTINGS')),
        tabItem: TabItem.more,
        body: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(8),
          itemCount: children.length,
          itemBuilder: (BuildContext context, int index) {
            var child = children[index];

            return child;
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 15.0, color: Colors.transparent),
        ));
  }
}
