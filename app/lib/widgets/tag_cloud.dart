import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';

typedef OnSelectedCallback = Function(String value);

class TagCloud extends StatelessWidget {
  final OnSelectedCallback onSelected;
  final Iterable<String> tags;
  final String selected;

  TagCloud({@required this.onSelected, @required this.tags, this.selected});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = this
        .tags
        .map((tag) => OutlinedButton(
            style: this.selected == tag
                ? OutlinedButton.styleFrom(
                    backgroundColor: Styles.appPrimaryColor,
                    primary: Colors.white,
                    shape: StadiumBorder())
                : OutlinedButton.styleFrom(shape: StadiumBorder()),
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
