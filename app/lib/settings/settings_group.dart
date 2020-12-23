import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final List<Widget> items;

  SettingsGroup(this.items);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Styles.overlayBgColor,
        margin: EdgeInsets.zero,
        child: Column(
          children: List.generate(this.items.length, (index) {
            var child = this.items[index];

            if (index != this.items.length - 1) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Styles.borderColor, width: 1))),
                child: child,
              );
            }

            return child;
          }),
        ));
  }
}
