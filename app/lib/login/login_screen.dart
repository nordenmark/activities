import 'package:app/auth/auth_controller.dart';
import 'package:app/auth/auth_service.dart';
import 'package:app/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class LoginScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authService = useProvider(authServiceProvider);
    final authController = useProvider(authControllerProvider);
    final isLoading = useState(false);
    final errorMessage = useState('');

    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: LoginForm(
                isLoading: isLoading.value,
                errorMessage: errorMessage.value,
                onSubmit: (email, password) async {
                  errorMessage.value = '';
                  isLoading.value = true;
                  var response =
                      await authService.login(Credentials(email, password));
                  isLoading.value = false;

                  if (response == null) {
                    errorMessage.value = 'Invalid email or password';
                    _showError(context);
                  } else {
                    authController.setState(
                        user: response.user,
                        accessToken: response.accessToken,
                        refreshToken: response.refreshToken);
                  }
                })));
  }

  _showError(BuildContext context) {
    final snackBar =
        SnackBar(content: Text('Oops! Invalid email or password!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
