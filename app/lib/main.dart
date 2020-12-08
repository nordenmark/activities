import 'package:app/root/authentication_wrapper.dart';
import 'package:app/root/splash_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

void main() {
  runApp(ProviderScope(
      child: SplashApp(
    onInitializationComplete: () => runMainApp(),
  )));
}

void runMainApp() {
  runApp(ProviderScope(child: WorkoutsApp()));
}

class WorkoutsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Workouts',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
      ),
      home: AuthenticationWrapper(),
    );
  }
}
