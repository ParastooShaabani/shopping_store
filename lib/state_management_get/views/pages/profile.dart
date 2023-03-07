import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/login_sign_up_controller.dart';
import 'package:shopping_store/state_management_get/views/pages/welcome.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_dialog.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text_field.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final LoginSignUpController loginSignUpController =
      Get.put(LoginSignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FixedVariables.normalHeight,
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          _buildMyText(
                            'اطلاعات کاربری',
                            28,
                            FixedVariables.purple1,
                          ),
                          const Spacer(),
                          InkWell(
                            child: _buildMyText(
                                'خروج از حساب کاربری', 20, FixedVariables.red),
                            onTap: () {
                              Get.to(() => const Welcome());
                            },
                          ),
                        ],
                      ),
                    ),
                    _buildProfilePicture(context),
                    _buildMyTextField('ایمیل'),
                    _buildMyTextField('نام کاربری'),
                    FixedVariables.littleHeight,
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: _buildMyText(
                        'در صورتی که نمی خواهید رمز را تغییر دهید، فیلد زیر را خالی بگذارید',
                        18,
                        Colors.black,
                      ),
                    ),
                    _buildMyTextField('رمز عبور فعلی'),
                    _buildMyTextField('رمز عبور جدید'),
                    FixedVariables.bigHeight,
                    _buildMyButton('ثبت تغییرات'),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyText(String text, double fontSize, Color color) {
    return MyText(
      text: text,
      fontSize: fontSize,
      color: color,
    );
  }

  Widget _buildMyButton(String text) {
    return MyButton(
      text: text,
      textColor: Colors.white,
      onPressed: () {},
      backgroundColor: FixedVariables.purple1,
      borderSideColor: FixedVariables.purple1,
      borderSideWidth: 2,
      buttonHeight: 70,
      buttonWidth: null,
      fontSize: 20,
      borderRadius: 10,
      padding: 5,
    );
  }

  Widget _buildMyTextField(String hintText) {
    return MyTextField(
      textColor: Colors.purple,
      borderRadius: 25,
      colorBorderSide: FixedVariables.purple1,
      fontSize: 20,
      hintText: hintText,
      secure: true,
      paddingSize: 20,
    );
  }

  Widget _buildProfilePicture(BuildContext context) {
    return InkWell(
      onTap: () {
        _showMyDialog(context);
      },
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/unknown_person.png'),
              fit: BoxFit.contain),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) => Directionality(
              textDirection: TextDirection.rtl,
              child: MyDialog(
                textChoice1: 'گالری',
                textChoice2: 'دوربین',
                text: 'انتخاب عکس پروفایل',
                onPressedCh1: () {
                  Navigator.pop(context);
                  _getFromGallery();
                },
                onPressedCh2: () {
                  Navigator.pop(context);
                  _getFromCamera();
                },
              ),
            ));
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
    );
    if (pickedFile != null) {
      loginSignUpController.imageFile = File(pickedFile.path);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      loginSignUpController.imageFile = File(pickedFile.path);
    }
  }
}
