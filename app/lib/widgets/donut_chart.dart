import 'dart:math';

import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';

class ChartEntry {
  final String key;
  final double value;
  final IconData icon;

  ChartEntry(this.key, this.value, this.icon);
}

class DonutChart extends StatelessWidget {
  final List<ChartEntry> entries;

  const DonutChart({Key key, this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 100 / 100,
      child: Container(child: CustomPaint(painter: CirclePainter(entries))),
    );
  }
}

class CirclePainter extends CustomPainter {
  final List<ChartEntry> entries;

  CirclePainter(this.entries);

  @override
  void paint(Canvas canvas, Size size) {
    double total = this
        .entries
        .map((entry) => entry.value)
        .reduce((value, element) => value + element);

    double startAngle = 3 / 2 * pi;

    this.entries.asMap().entries.forEach((entry) {
      var paint = Paint()
        ..color = ColorPalette.get(entry.key)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 100;

      double percentage = entry.value.value / total;
      double sweepAngle = this._getRadiansFromPercentage(percentage);

      canvas.drawArc(Offset(0, 0) & Size(size.width, size.height), startAngle,
          sweepAngle, false, paint);

      startAngle = startAngle + sweepAngle;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  double _getRadiansFromPercentage(double percentage) {
    if (percentage < 0) {
      percentage = 0;
    } else if (percentage > 1) {
      percentage = 1;
    }

    return 2 * pi * percentage;
  }
}
