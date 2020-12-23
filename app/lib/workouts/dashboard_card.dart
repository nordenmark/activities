import 'package:app/utils/styles.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;
  final String title;

  const DashboardCard({Key key, this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget renderChild;

    if (this.title != null) {
      renderChild = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(this.title, type: TextType.H3),
          this.child,
        ],
      );
    } else {
      renderChild = this.child;
    }

    return Card(
        margin: EdgeInsets.zero,
        color: Styles.overlayBgColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: renderChild,
        ));
  }
}
