import 'package:flutter/cupertino.dart';

enum TextType {
  H1,
  H2,
  H3,
  H4,
  H5,
  H6,
  SUBTITLE1,
  SUBTITLE2,
  BODY,
  BODY2,
}

class CustomText extends StatelessWidget {
  final String text;
  final TextType type;
  final TextStyle style;

  CustomText(this.text,
      {this.type = TextType.BODY, this.style = const TextStyle()});

  final Map<TextType, TextStyle> mapping = {
    TextType.H1: TextStyle(fontSize: 96, fontWeight: FontWeight.w300),
    TextType.H2: TextStyle(fontSize: 60, fontWeight: FontWeight.w300),
    TextType.H3: TextStyle(fontSize: 48, fontWeight: FontWeight.normal),
    TextType.H4: TextStyle(fontSize: 34, fontWeight: FontWeight.normal),
    TextType.H5: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
    TextType.H6: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    TextType.SUBTITLE1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    TextType.SUBTITLE2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    TextType.BODY: TextStyle(fontSize: 16),
    TextType.BODY2: TextStyle(fontSize: 14),
  };

  @override
  Widget build(BuildContext context) {
    var style = mapping[this.type].merge(this.style);

    return Text(this.text, style: style);
  }
}
