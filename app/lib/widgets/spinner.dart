import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  final String text;

  const Spinner({Key key, this.text = 'Loading...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(this.text),
        ),
        CircularProgressIndicator(),
      ],
    );
  }
}
