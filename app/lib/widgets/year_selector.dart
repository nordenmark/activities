import 'dart:math';

import 'package:flutter/material.dart';

import 'tag_cloud.dart';

class YearSelector extends StatelessWidget {
  final int selectedYear;
  final Function(int) onSelected;

  const YearSelector(
      {Key key, @required this.selectedYear, @required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Show year:'),
        SizedBox(width: 8),
        Container(
          child: TagCloud(
              tags: this._getYears(),
              selected: selectedYear.toString(),
              onSelected: (String year) {
                this.onSelected(int.parse(year));
              }),
        ),
      ],
    );
  }

  List<String> _getYears() {
    final int from = DateTime.now().year;
    final int to = 2020;

    var list =
        List.generate(from - to + 1, (index) => (from - index).toString());

    return list.sublist(0, min(3, list.length));
  }
}
