import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.heightText})
      : super(key: key);

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final double? heightText;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: heightText,
      ),
    );
  }
}
