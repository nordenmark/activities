import 'package:app/auth/auth_controller.dart';
import 'package:app/auth/tokens.dart';
import 'package:app/models/user.model.dart';
import 'package:app/root/splash_screen.dart';
import 'package:app/storage/storage_service.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SplashApp extends StatefulHookWidget {
  final VoidCallback onInitializationComplete;

  const SplashApp({
    Key key,
    @required this.onInitializationComplete,
  }) : super(key: key);

  @override
  _SplashAppState createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  @override
  void initState() {
    super.initState();
    _initializeAsyncDependencies();
  }

  Future<void> _initializeAsyncDependencies() async {
    final authController = context.read(authControllerProvider);
    final storageService = context.read(storageServiceProvider);

    Token accessToken = await storageService.getAccessToken();
    Token refreshToken = await storageService.getRefreshToken();
    User user = await storageService.getUser();

    if (accessToken != null && user != null && refreshToken != null) {
      print("Tokens found in storage, updating state");
      authController.setState(
          user: user, accessToken: accessToken, refreshToken: refreshToken);
    } else {
      print("No tokens or user found in storage, clean startup");
    }

    widget.onInitializationComplete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workouts - loading',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(context),
      home: SplashScreen(),
    );
  }
}
