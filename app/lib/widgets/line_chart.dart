import 'dart:ui';

import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class LineChartPoint {
  DateTime date;
  int count;

  LineChartPoint({@required this.date, @required this.count});
}

class LineChart extends StatelessWidget {
  final Map<String, List<LineChartPoint>> data;
  final int target;
  final int maxValue;

  const LineChart({Key key, this.data, this.target, this.maxValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stepSize = 20;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                  width: 30,
                  height: double.infinity,
                  child: CustomPaint(
                      painter: _YAxisPainter(this.maxValue, stepSize))),
              Expanded(
                child: Container(
                    height: double.infinity,
                    child: CustomPaint(
                        painter: _BackgroundPainter(
                            this.target, this.maxValue, stepSize),
                        foregroundPainter: _LineChartPainter(
                            this.data, this.maxValue, this.target))),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: this.data.keys.map((name) {
                    Color color =
                        ColorPalette.get(data.keys.toList().indexOf(name));
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(width: 14, height: 14, color: color),
                        SizedBox(width: 4),
                        Text(name),
                      ],
                    );
                  }).toList()),
            ),
          )
        ],
      ),
    );
  }
}

class _YAxisPainter extends CustomPainter {
  final int maxValue;
  final int stepSize;

  _YAxisPainter(this.maxValue, this.stepSize);

  @override
  void paint(Canvas canvas, Size size) {
    final pixelsPerValue = size.height / this.maxValue;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    var steps = [];

    for (int i = 0; i < this.maxValue; i += this.stepSize) {
      steps.add(i);
    }

    steps.reversed.forEach((step) {
      final textSpan = TextSpan(
        text: '$step',
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.end,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      final double x = 0;
      final yShift = 14; // To make the number appear above the line
      final double y = size.height - (pixelsPerValue * step) - yShift;
      final offset = Offset(x, y);

      textPainter.paint(canvas, offset);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Breakpoint {
  final DateTime date;
  final int index;

  Breakpoint(this.date, this.index);
}

class _LineChartPainter extends CustomPainter {
  final Map<String, List<LineChartPoint>> data;
  final int maxValue;
  final int target;

  _LineChartPainter(this.data, this.maxValue, this.target);

  @override
  void paint(Canvas canvas, Size size) {
    final widthFactor = size.width / data.values.first.length;

    final double pixelsPerValue = size.height / this.maxValue;

    List<Breakpoint> breakpoints = [];

    data.entries.forEach((entry) {
      final pointMode = PointMode.polygon;

      Color historicColor =
          ColorPalette.get(data.keys.toList().indexOf(entry.key));
      Color futureColor = historicColor.withOpacity(0.08);

      var paint = Paint()
        ..color = historicColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = 4;

      String user = entry.key;

      List<LineChartPoint> historic = entry.value
          .where((element) => element.date.isBefore(DateTime.now()))
          .toList();
      List<LineChartPoint> future = entry.value
          .where((element) => element.date.isAfter(DateTime.now()))
          .toList();

      final List<Offset> historicalPoints =
          _buildPointsFromData(0, historic, size, widthFactor, pixelsPerValue);

      final averageDailyCount = _getAverageDailyCount(historic);

      final List<Offset> futurePoints = _buildProjectedPoints(
          historicalPoints.last,
          averageDailyCount,
          future.length,
          size,
          widthFactor,
          pixelsPerValue);

      canvas.drawPoints(pointMode, historicalPoints, paint);
      canvas.drawPoints(pointMode, futurePoints, paint..color = futureColor);

      var breakpoint = _findBreakpoint(entry.value, this.target);

      if (breakpoint != null) {
        breakpoints.add(breakpoint);
      }
    });

    _paintBreakpoints(
        canvas, size, breakpoints, widthFactor, pixelsPerValue, this.target);
  }

  _paintBreakpoints(Canvas canvas, Size size, List<Breakpoint> bps,
      double widthFactor, double pixelsPerValue, int target) {
    List<Offset> labelOffsets = [
      Offset(-120, -100),
      Offset(-120, -50),
    ];

    bps.asMap().entries.forEach((entry) {
      var index = entry.key;
      var bp = entry.value;

      var paint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      var x = widthFactor * bp.index;
      var y = size.height - (target * pixelsPerValue);

      Offset center = Offset(x, y);

      canvas.drawCircle(center, 6, paint);

      _paintBreakpointLabel(canvas, size, bp.date, center,
          labelOffsets[index % labelOffsets.length]);
    });
  }

  _paintBreakpointLabel(
      Canvas canvas, Size size, DateTime date, Offset origin, Offset offset) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    final textSpan = TextSpan(
      text: intl.DateFormat('y-MM-dd').format(date),
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    final double x = origin.dx + offset.dx;
    final double y = origin.dy + offset.dy;
    final position = Offset(x, y);

    textPainter.paint(canvas, position);

    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var arrowFrom = origin.translate(-1, -3);
    var arrowTo = position.translate(78, 14);

    canvas.drawLine(arrowFrom, arrowTo, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  _findBreakpoint(List<LineChartPoint> points, int target) {
    try {
      var breakpoint = points.firstWhere((element) => element.count >= target);
      return Breakpoint(breakpoint.date, points.indexOf(breakpoint));
    } catch (e) {}

    // Breakpoint not yet reached, use projection to find when it'll occur
    List<LineChartPoint> historic = points
        .where((element) => element.date.isBefore(DateTime.now()))
        .toList();

    List<LineChartPoint> future = points
        .where((element) => element.date.isAfter(DateTime.now()))
        .toList();

    final averageDailyCount = _getAverageDailyCount(historic);

    for (final entry in future.asMap().entries) {
      final projectedCount =
          entry.value.count + (entry.key * averageDailyCount);

      if (projectedCount >= target) {
        return Breakpoint(entry.value.date, historic.length + entry.key - 1);
      }
    }

    return null;
  }

  double _getAverageDailyCount(List<LineChartPoint> list) {
    return (list.last.count - list.first.count) / list.length;
  }

  List<Offset> _buildPointsFromData(double startX, List<LineChartPoint> list,
      Size size, double widthFactor, double heightFactor) {
    double height = size.height;

    List<Offset> points = list.asMap().entries.map((entry) {
      final index = entry.key;
      final x = startX + index * widthFactor;
      final y = height - (entry.value.count * heightFactor);
      return Offset(x, y);
    }).toList();

    return points;
  }

  List<Offset> _buildProjectedPoints(Offset start, double delta, int count,
      Size size, double widthFactor, double heightFactor) {
    List<Offset> points = [];

    for (int i = 0; i < count; i++) {
      final x = start.dx + (i * widthFactor);
      final y = start.dy - (i * delta * heightFactor);

      if (y >= 0) {
        points.add(Offset(x, y));
      }
    }

    return points;
  }
}

class _BackgroundPainter extends CustomPainter {
  final int target;
  final int maxValue;
  final int stepSize;

  _BackgroundPainter(this.target, this.maxValue, this.stepSize);

  @override
  void paint(Canvas canvas, Size size) {
    final pixelsPerValue = size.height / this.maxValue;

    _paintTarget(canvas, size, pixelsPerValue);
    _paintGridLines(canvas, size, pixelsPerValue);
  }

  _paintTarget(Canvas canvas, Size size, double pixelsPerValue) {
    const int dashWidth = 4;
    const int dashGap = 8;

    var paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    double startX = 0;
    double y = size.height - this.target * pixelsPerValue;

    while (startX < size.width) {
      Offset from = Offset(startX, y);
      Offset to = Offset(startX + dashWidth, y);

      canvas.drawLine(from, to, paint);

      startX += dashWidth + dashGap;
    }
  }

  _paintGridLines(Canvas canvas, Size size, double pixelsPerValue) {
    var paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    int currentStep = 0;

    while (currentStep < this.maxValue) {
      final y = size.height - pixelsPerValue * currentStep;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      currentStep += stepSize;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
