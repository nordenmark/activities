import 'package:app/utils/validators.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/centered_form.dart';
import 'package:app/widgets/custom_input.dart';
import 'package:app/widgets/spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginForm extends HookWidget {
  final Function(String, String) onSubmit;
  final bool isLoading;
  final String errorMessage;

  LoginForm({@required this.onSubmit, this.isLoading, this.errorMessage});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    List<Widget> formElements = [
      SizedBox(height: 80),
      Image.asset('assets/images/logo_dark.png', height: 140),
      AutofillGroup(
        child: Column(children: [
          CustomInput(
            autofillHints: [AutofillHints.username],
            controller: emailController,
            label: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            validator: (value) =>
                Validators.isValidEmail(value) ? null : 'Invalid email address',
          ),
          SizedBox(height: 8),
          CustomInput(
            autofillHints: [AutofillHints.password],
            controller: passwordController,
            label: 'Password',
            icon: Icons.lock,
            obscureText: true,
            autocorrect: false,
            validator: (value) =>
                Validators.isValidPassword(value) ? null : 'Password too short',
          ),
        ]),
      ),
      Button(
        label: 'Login',
        onPressed: this.isLoading
            ? null
            : () => _formSubmitted(emailController, passwordController),
      )
    ];

    if (this.isLoading) {
      formElements.add(Spinner(text: 'Logging in...'));
    }

    return CenteredForm(
      formKey: _formKey,
      children: formElements,
    );
  }

  _formSubmitted(TextEditingController emailController,
      TextEditingController passwordController) {
    if (this._formKey.currentState.validate()) {
      this.onSubmit(emailController.text, passwordController.text);
    }
  }
}
