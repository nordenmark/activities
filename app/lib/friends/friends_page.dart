import 'package:app/friends/friends_list.dart';
import 'package:app/widgets/tab_item.dart';
import 'package:app/widgets/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'friends_controller.dart';

class FriendsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final friends = useProvider(friendsControllerProvider.state).friends;

    return TabScreen(
        appBar: AppBar(title: Text('FRIENDS')),
        tabItem: TabItem.friends,
        body: FriendsList(friends));
  }
}
