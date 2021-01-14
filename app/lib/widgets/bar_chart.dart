import 'dart:math';

import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BarChartEntry {
  final String label;
  final int value;

  BarChartEntry(this.label, this.value);
}

class BarChart extends HookWidget {
  final Duration duration = const Duration(milliseconds: 600);
  final List<BarChartEntry> entries;
  final double height;

  const BarChart({Key key, this.entries, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double labelHeight = 20;
    final barHeight = this.height - (labelHeight * 2);
    final maxValue = this.entries.map((entry) => entry.value).reduce(max);
    final heightPerValue = barHeight / maxValue;

    final animationController = useAnimationController(duration: duration);
    animationController.reset();
    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInCubic,
    );
    animationController.forward();

    return Container(
      height: this.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: this.entries.length,
        itemBuilder: (BuildContext context, int index) {
          var entry = this.entries[index];

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  height: labelHeight, child: Text(entry.value.toString())),
              BarChartBar(
                  width: 50,
                  height: entry.value * heightPerValue,
                  controller: animation),
              Container(height: labelHeight, child: Text(entry.label)),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(width: 25);
        },
      ),
    );
  }
}

class BarChartBar extends AnimatedWidget {
  final double width;
  final double height;
  final Animation controller;

  BarChartBar({this.width, this.height, this.controller})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.appPrimaryColor,
      width: this.width,
      height: this.height * controller.value,
    );
  }
}
