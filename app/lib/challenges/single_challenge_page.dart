import 'package:app/models/challenge.model.dart';
import 'package:flutter/material.dart';

class SingleChallengePage extends StatelessWidget {
  final Challenge challenge;

  const SingleChallengePage({Key key, this.challenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              this.challenge != null ? this.challenge.name : 'ADD CHALLENGE'),
        ),
        body: Container(
          child: Text('hello'),
        ));
  }
}
