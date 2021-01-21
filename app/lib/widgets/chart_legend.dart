import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';
import 'donut_chart.dart';

class ChartLegend extends StatelessWidget {
  final List<ChartEntry> entries;

  const ChartLegend({Key key, this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalCount = this
        .entries
        .map((entry) => entry.value)
        .reduce((value, element) => value + element);

    List<Widget> children = this.entries.asMap().entries.map((entry) {
      var label = entry.value.key;
      var icon = entry.value.icon;
      var count = entry.value.value.toInt();
      var percentage = (count / totalCount * 100).toInt();
      var index = entry.key;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children: [
            Container(
                width: 40,
                height: 40,
                color: ColorPalette.get(index),
                child: Icon(icon, color: Colors.white)),
            SizedBox(width: 8),
            CustomText(label),
            CustomText(
                " ($count ${count == 1 ? 'time' : 'times'}, $percentage %)"),
          ],
        ),
      );
    }).toList();

    return Column(
      children: children,
    );
  }
}
