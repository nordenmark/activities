import 'package:flutter/cupertino.dart';

class SettingsGroup extends StatelessWidget {
  final List<Widget> items;

  SettingsGroup(this.items);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CupertinoColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: this.items,
        ));
  }
}
