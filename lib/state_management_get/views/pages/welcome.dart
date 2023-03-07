import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/views/pages/login.dart';
import 'package:shopping_store/state_management_get/views/pages/sign_up.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/welcome.png',
                    ),
                    FixedVariables.littleHeight,
                    _buildMyText('خوش آمدید به', 30),
                    FixedVariables.littleHeight,
                    _buildMyText(' Mellow ', 40),
                    FixedVariables.littleHeight,
                    _buildMyText(
                        ' :) خرید آسان و سریع را با ما تجربه کنید', 20),
                    const SizedBox(
                      height: 200,
                    ),
                    _buildMyButton('ورود', () {
                      Get.to(() => Login());
                    }, FixedVariables.purple1),
                    FixedVariables.littleHeight,
                    _buildMyButton('ثبت نام', () {
                      Get.to(() => SignUp());
                    }, FixedVariables.purple2),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyButton(
      String text, Function()? onPressed, Color backgroundColor) {
    return MyButton(
      onPressed: onPressed,
      text: text,
      textColor: Colors.white,
      backgroundColor: backgroundColor,
      borderSideColor: backgroundColor,
      borderSideWidth: 2,
      buttonHeight: 70,
      buttonWidth: 400,
      fontSize: 22,
      borderRadius: 10,
      padding: 5,
    );
  }

  Widget _buildMyText(String text, double fontSize) {
    return MyText(
      text: text,
      fontSize: fontSize,
    );
  }
}
