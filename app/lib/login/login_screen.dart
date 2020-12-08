import 'package:app/auth/auth_controller.dart';
import 'package:app/auth/auth_service.dart';
import 'package:app/login/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class LoginScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authService = useProvider(authServiceProvider);
    final authController = useProvider(authControllerProvider);

    return CupertinoPageScaffold(
        child: Center(
            child: LoginForm(
                isLoading: false, // @TODO get from state
                errorMessage: '', // @TODO get from state
                onSubmit: (email, password) async {
                  // @TODO loading to LoginForm
                  var response =
                      await authService.login(Credentials(email, password));

                  if (response == null) {
                    // @TODO error to loginForm
                    print(
                        "Error response, tokens null, return error to child widget");
                  } else {
                    print("successful login, response ${response.toString()}");
                    authController.initialize(
                        user: response.user,
                        accessToken: response.accessToken,
                        refreshToken: response.refreshToken);
                  }
                })));
  }
}
