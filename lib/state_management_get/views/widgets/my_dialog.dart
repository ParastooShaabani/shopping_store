import 'package:flutter/material.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';

class MyDialog extends StatelessWidget {
  const MyDialog(
      {Key? key,
      required this.text,
      required this.textChoice1,
      required this.textChoice2,
      this.onPressedCh1,
      this.onPressedCh2})
      : super(key: key);
  final String text;
  final String textChoice1;
  final String textChoice2;
  final void Function()? onPressedCh1;
  final void Function()? onPressedCh2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: MyText(text: FixedVariables.shopName),
      content: MyText(text: text),
      actions: <Widget>[
        TextButton(
          onPressed: onPressedCh1,
          child: Text(textChoice1),
        ),
        TextButton(
          onPressed: onPressedCh2,
          child: Text(textChoice2),
        ),
      ],
    );
  }
}
