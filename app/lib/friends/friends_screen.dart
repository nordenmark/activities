import 'package:app/friends/friends_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'friends_list.dart';

class FriendsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FRIENDS'),
      ),
      body: Consumer(builder: (context, watch, child) {
        final friends = watch(friendsControllerProvider.state).friends;

        return FriendsList(friends);
      }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("ADD FRIEND");
          }),
    );
  }
}
