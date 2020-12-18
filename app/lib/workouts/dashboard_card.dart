import 'package:app/utils/styles.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';

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

    return Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        color: Styles.overlayBgColor,
        child: renderChild);
  }
}
