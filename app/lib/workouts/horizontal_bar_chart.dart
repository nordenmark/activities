import 'dart:math';

import 'package:app/utils/colors.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BarChartEntry {
  String label;
  int count;

  BarChartEntry(this.label, this.count);
}

class HorizontalBarChart extends HookWidget {
  final Duration duration = const Duration(milliseconds: 1000);
  final List<BarChartEntry> entries;

  HorizontalBarChart(this.entries);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: duration);
    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    animationController.forward();

    this.entries.sort((a, b) => b.count - a.count);

    List<Widget> children = this.entries.asMap().entries.map((mapEntry) {
      var index = mapEntry.key;
      var entry = mapEntry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: HorizontalBar(
            label: entry.label,
            count: entry.count,
            color: ColorPalette.get(index),
            controller: animation),
      );
    }).toList();

    return Column(
      children: children,
    );
  }
}

class HorizontalBar extends AnimatedWidget {
  final String label;
  final int count;
  final Color color;
  final Animation controller;

  HorizontalBar({Key key, this.label, this.count, this.color, this.controller})
      : super(key: key, listenable: controller);

  final BoxDecoration leftDecoration = const BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
  );

  final BoxDecoration rightDecoration = const BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> leftChildren = [
      Container(
        height: 24,
        decoration: leftDecoration.copyWith(
          color: Colors.red[50],
        ),
      ),
    ];

    Widget left = Stack(
      alignment: Alignment.centerRight,
      children: leftChildren,
    );

    List<Widget> rightChildren = [
      Container(
        height: 24,
        decoration: rightDecoration.copyWith(
          color: Colors.green[50],
        ),
      ),
    ];

    Widget right =
        Stack(alignment: Alignment.centerLeft, children: rightChildren);

    if (this.count < 0) {
      leftChildren.add(this._getBar(this.count, this.controller.value));
      leftChildren.add(this._getBarLabel(this.count));
    } else if (this.count > 0) {
      rightChildren.add(this._getBar(this.count, this.controller.value));
      rightChildren.add(this._getBarLabel(this.count));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(label, type: TextType.H7),
        SizedBox(height: 6),
        Row(children: [Expanded(child: left), Expanded(child: right)])
      ],
    );
  }

  Widget _getBar(int count, double animation) {
    BoxDecoration decoration =
        count < 0 ? this.leftDecoration : this.rightDecoration;

    return FractionallySizedBox(
      widthFactor: this._getWidthFactorFromCount(count) * animation,
      child: Container(
        height: 24,
        decoration: decoration,
      ),
    );
  }

  double _getWidthFactorFromCount(int count) {
    return min(5, count.abs()) / 5;
  }

  Color _getColorForText(int count) {
    return count.abs() >= 5 ? Colors.white : Colors.black;
  }

  Widget _getBarLabel(int count) {
    if (count < 0) {
      return Positioned(
          left: 10,
          child: Text(this.count.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getColorForText(this.count))));
    } else {
      return Positioned(
          right: 10,
          child: Text(this.count.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getColorForText(this.count))));
    }
  }
}
