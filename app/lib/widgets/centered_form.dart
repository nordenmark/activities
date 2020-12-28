import 'package:flutter/material.dart';

class CenteredForm extends StatelessWidget {
  final List<Widget> children;
  final GlobalKey<FormState> formKey;

  const CenteredForm({Key key, this.children, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = SingleChildScrollView(
        child: ListView.builder(
      itemCount: this.children.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: this.children[index],
        );
      },
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shrinkWrap: true,
    ));

    return Form(
      key: this.formKey,
      child: list,
    );
  }
}
