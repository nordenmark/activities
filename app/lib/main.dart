import 'package:app/root/authentication_wrapper.dart';
import 'package:app/root/splash_app.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('sv', 'SE'),
      ],
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(context),
      home: AuthenticationWrapper(),
    );
  }
}
