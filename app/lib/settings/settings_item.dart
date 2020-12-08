import 'package:flutter/cupertino.dart';

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
          left: 15.0,
          bottom: 2.0,
          right: 10.0,
        ),
        child: Icon(this.icon));

    Widget labelWidget = Text(this.label);

    return Container(
        color: CupertinoColors.white,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onPress,
            child: SizedBox(
                height: 44.0,
                child: Row(children: [
                  iconWidget,
                  labelWidget,
                ]))));
  }
}
