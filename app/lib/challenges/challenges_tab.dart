import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/all.dart';

class ChallengesTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Center(child: Text('Challenges'));
  }
}
