import 'package:flutter/material.dart';

enum ButtonSize { DEFAULT, BIG }
enum ButtonType { PRIMARY, DANGER }

class Button extends StatelessWidget {
  final String label;
  final Function onPressed;
  final ButtonSize size;
  final ButtonType type;

  Button(
      {this.label,
      this.onPressed,
      this.size = ButtonSize.DEFAULT,
      this.type = ButtonType.PRIMARY});

  @override
  Widget build(BuildContext context) {
    var padding = size == ButtonSize.DEFAULT
        ? EdgeInsets.symmetric(horizontal: 12, vertical: 4)
        : EdgeInsets.symmetric(horizontal: 20, vertical: 30);

    if (this.type == ButtonType.DANGER) {
      return TextButton(
          onPressed: this.onPressed,
          child: Text(this.label),
          style: TextButton.styleFrom(
            primary: Colors.red,
          ));
    }

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
        ),
        onPressed: this.onPressed,
        child: Text(
          this.label,
        ));
  }
}
