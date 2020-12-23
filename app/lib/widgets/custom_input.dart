import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final Function onTap;
  final String label;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final TextInputType keyboardType;
  final bool autocorrect;
  final bool obscureText;
  final IconData icon;
  final Iterable<String> autofillHints;

  const CustomInput(
      {Key key,
      this.onTap,
      @required this.label,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.autocorrect = true,
      this.obscureText = false,
      this.icon,
      this.autofillHints = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: this.autofillHints,
      controller: this.controller,
      autofocus: false,
      decoration: InputDecoration(
        labelText: this.label,
        border: OutlineInputBorder(),
        icon: this.icon != null ? Icon(this.icon) : null,
      ),
      validator: this.validator,
      keyboardType: this.keyboardType,
      autocorrect: this.autocorrect,
      obscureText: this.obscureText,
      onTap: this.onTap,
    );
  }
}
