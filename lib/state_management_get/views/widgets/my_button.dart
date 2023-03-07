import 'package:flutter/material.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    // Button
    this.onPressed,
    this.backgroundColor,
    required this.borderSideColor,
    required this.borderSideWidth,
    required this.borderRadius,
    required this.padding,
    required this.buttonWidth,
    required this.buttonHeight,

    // Text in Button
    required this.text,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.heightText,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  // Button
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color borderSideColor;
  final double borderSideWidth;
  final double borderRadius;
  final double padding;
  final double? buttonWidth;
  final double buttonHeight;

  // Text in Button
  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? heightText;

  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth ?? MediaQuery.of(context).size.width,
      height: buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          side: BorderSide(color: borderSideColor, width: borderSideWidth),
        ),
        child: MyText(
          text: text,
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
          heightText: heightText,
        ),
      ),
    );
  }
}
