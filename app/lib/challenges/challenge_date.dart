import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChallengeDate extends StatelessWidget {
  final DateTime date;
  final Function(bool) onToggle;
  final bool toggled;

  const ChallengeDate({Key key, this.date, this.onToggle, this.toggled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Styles.white,
      child: Row(
        children: [
          Switch(
            onChanged: this.onToggle,
            value: this.toggled,
          ),
          Text(DateFormat('y-MM-dd').format(date)),
          SizedBox(width: 10),
          CircleAvatar(child: Text('NN')),
          CircleAvatar(child: Text('LE')),
        ],
      ),
    );
  }
}
