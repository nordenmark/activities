import 'package:app/friends/friends_controller.dart';
import 'package:app/widgets/spinner.dart';
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
        return watch(friendsControllerProvider.state).when(
            data: (friends) => FriendsList(friends),
            loading: () => Center(child: Spinner()),
            error: (e, stack) => Text(e.toString()));
      }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("ADD FRIEND");
          }),
    );
  }
}
