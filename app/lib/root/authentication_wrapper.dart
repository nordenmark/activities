import 'package:app/auth/auth_controller.dart';
import 'package:app/login/login_screen.dart';
import 'package:app/dashboard/dashboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthenticationWrapper extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authState = useProvider(authControllerProvider);

    if (!authState.isLoggedIn) {
      return LoginScreen();
    }

    return DashboardPage();
  }
}
