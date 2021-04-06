import 'package:app/root/authentication_wrapper.dart';
import 'package:app/root/splash_app.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workouts',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(context),
      home: AuthenticationWrapper(),
    );
  }
}
