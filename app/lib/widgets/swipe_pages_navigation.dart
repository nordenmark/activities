import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SwipePagesNavigation extends AnimatedWidget {
  final PageController controller;
  final ValueChanged<int> onPageSelected;
  final List<String> labels;

  SwipePagesNavigation(
      {@required this.controller,
      @required this.onPageSelected,
      @required this.labels})
      : super(listenable: controller);

  Widget _buildItem(int index) {
    return GestureDetector(
        onTap: () => this.onPageSelected(index),
        child: Text(
          labels[index],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List<Widget>.generate(labels.length, _buildItem),
    );
  }
}
