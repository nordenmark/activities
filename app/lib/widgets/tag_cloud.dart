import 'package:flutter/material.dart';

typedef OnSelectedCallback = Function(String value);

class TagCloud extends StatelessWidget {
  final OnSelectedCallback onSelected;
  final Iterable<String> tags;

  TagCloud({this.onSelected, this.tags});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = this
        .tags
        .map((tag) => OutlinedButton(
            style: OutlinedButton.styleFrom(shape: StadiumBorder()),
            child: Text(tag),
            onPressed: () {
              onSelected(tag);
            }))
        .toList();

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: widgets,
    );
  }
}
