import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

typedef Future<void> PressOperationCallback();

class SettingsItem extends StatelessWidget {
  final String label;
  final PressOperationCallback onPress;
  final IconData icon;

  const SettingsItem({Key key, this.label, this.onPress, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
        ),
        child: Icon(this.icon));

    Widget labelWidget = Text(this.label);

    Widget chevron = Icon(FlutterIcons.chevron_right_mdi);

    return InkWell(
        onTap: onPress,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 44.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    iconWidget,
                    labelWidget,
                  ]),
                  chevron
                ])));
  }
}
