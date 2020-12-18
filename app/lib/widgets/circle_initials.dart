import 'package:flutter/cupertino.dart';

class CircleInitials extends StatelessWidget {
  final String text;

  CircleInitials(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CupertinoColors.systemBlue,
        ),
        child: Center(
          child: Text(this.text,
              style: TextStyle(fontSize: 26, color: CupertinoColors.white)),
        ));
  }
}
