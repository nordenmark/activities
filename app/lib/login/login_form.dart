import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) onSubmit;
  final bool isLoading;
  final String errorMessage;

  const LoginForm({Key key, this.onSubmit, this.isLoading, this.errorMessage})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: 'nordenmark@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: 'ryssland');

  bool _emailValid = true;
  bool _passwordValid = true;

  bool get formValid => _emailValid && _passwordValid;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
  }

  _validateEmail() {
    String value = _emailController.text;

    bool valid = value.isNotEmpty && value.contains('@');

    setState(() {
      _emailValid = valid;
    });
  }

  _validatePassword() {
    String value = _passwordController.text;

    bool valid = value.isNotEmpty && value.length > 4;

    setState(() {
      _passwordValid = valid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _logo(),
            _emailField(),
            _passwordField(),
            _submitButton(formValid),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Image.asset('assets/images/logo_dark.png', height: 140),
    );
  }

  Widget _emailField() {
    return CupertinoTextField(
      controller: _emailController,
      placeholder: 'you@domain.com',
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
    );
  }

  Widget _passwordField() {
    return CupertinoTextField(
      controller: _passwordController,
      placeholder: 'password',
      obscureText: true,
      autocorrect: false,
    );
  }

  Widget _submitButton(bool isValid) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CupertinoButton(
            child: Text('Login'),
            onPressed: isValid ? _onFormSubmitted : null,
          ),
        ],
      ),
    );
  }

  void _onFormSubmitted() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.onSubmit(_emailController.text, _passwordController.text);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
