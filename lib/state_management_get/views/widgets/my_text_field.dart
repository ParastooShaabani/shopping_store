import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    this.onChanged,
    this.icon,
    this.onTap,
    this.boxColor,
    this.hintText,
    this.initialValue,
    this.labelText,
    this.textColor,
    this.fontSize,
    this.validator,
    this.maxLines,
    this.controller,
    required this.colorBorderSide,
    required this.secure,
    required this.borderRadius,
    required this.paddingSize,
  }) : super(key: key);

  final double paddingSize;
  final int? maxLines;
  final Color colorBorderSide;
  final double borderRadius;
  final Color? boxColor;
  final String? initialValue;
  final bool secure;
  final Function(String?)? onChanged;
  final String? hintText;
  final String? labelText;
  final Color? textColor;
  final double? fontSize;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  final Function()? onTap;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(top: paddingSize),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              color: boxColor),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines ?? 1,
            validator: validator,
            initialValue: initialValue,
            obscureText: secure,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: textColor, fontSize: fontSize),
              hintText: hintText,
              hintStyle: TextStyle(color: textColor, fontSize: fontSize),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: colorBorderSide, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: colorBorderSide, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorBorderSide, width: 2),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius))),
              suffixIcon:
                  InkWell(onTap: onTap, child: icon ?? const SizedBox()),
            ),
          ),
        ),
      ),
    );
  }
}
