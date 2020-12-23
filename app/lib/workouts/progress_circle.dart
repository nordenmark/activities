import 'dart:math';

import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final Color progressColor;
  final Color baseColor;
  final double progressPercent;
  final double width;
  final double height;

  const ProgressCircle({
    Key key,
    this.width = 100.0,
    this.height = 100.0,
    this.progressColor = Styles.appPrimaryColor,
    this.baseColor = Styles.appDiscreteColor,
    @required this.progressPercent,
  })  : assert(width == height),
        assert(progressPercent >= 0 && progressPercent <= 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final int progress = (this.progressPercent * 100).round();

    return Container(
      width: this.width,
      height: this.height,
      child: CustomPaint(
          child: Center(child: Text('$progress%')),
          foregroundPainter:
              CirclePainter(this.progressColor, this.progressPercent),
          painter: CirclePainter(this.baseColor, 1.0)),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  final double percentage;

  CirclePainter(this.color, this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = this.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(Offset(0, 0) & Size(size.width, size.height), 3 / 2 * pi,
        this._getRadiansFromPercentage(percentage), false, paint);
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
