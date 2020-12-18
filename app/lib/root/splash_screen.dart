import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  final String text;

  const SplashScreen({Key key, this.text = 'Loading...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(30.0),
          child: Image.asset('assets/images/logo_dark.png'),
        ),
        CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(this.text),
        ),
      ],
    )));
  }
}
