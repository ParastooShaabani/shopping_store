import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/favorite_controller.dart';
import 'package:shopping_store/state_management_get/controllers/login_sign_up_controller.dart';
import 'package:shopping_store/state_management_get/controllers/profile_controller.dart';
import 'package:shopping_store/state_management_get/controllers/user_controller.dart';
import 'package:shopping_store/state_management_get/models/user_model.dart';
import 'package:shopping_store/state_management_get/views/pages/welcome.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_dialog.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text_field.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final UserController userController = Get.put(UserController());
  final ProfileController profileController = Get.put(ProfileController());
  final FavoritesController favoritesController = Get.put(FavoritesController());
  final LoginSignUpController loginSignUpController =
      Get.put(LoginSignUpController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                              child: _buildMyText('خروج از حساب کاربری', 20,
                                  FixedVariables.red),
                              onTap: () {
                                print('tap khoruj before');
                                userController.exitAccount(profileController
                                    .userEmailProfileController.text);
                                favoritesController.removeFavorite();
                                print('tap khoruj after');
                                Get.to(() => const Welcome());
                              },
                            ),
                          ],
                        ),
                      ),
                      _buildProfilePicture(context),
                      _buildMyTextField(
                        labelText: 'ایمیل',
                        controller:
                            profileController.userEmailProfileController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return FixedVariables.errorEmpty;
                          } else if (!loginSignUpController
                              .checkEmailFormat(value)
                              .value) {
                            return FixedVariables.errorEmailFormat;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          loginSignUpController.checkEmailFormat(value!);
                        },
                      ),
                      _buildMyTextField(
                          labelText: 'نام کاربری',
                          controller:
                              profileController.userNameProfileController),
                      _buildMyTextField(
                        labelText: 'رمز عبور',
                        controller:
                            profileController.userPasswordProfileController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return FixedVariables.errorEmpty;
                          } else {
                            if (!loginSignUpController
                                .checkPasswordFormat(value)
                                .value) {
                              return FixedVariables.errorPassFormat;
                            }
                          }
                          return null;
                        },
                      ),
                      _buildMyTextField(
                        labelText: 'شماره تماس',
                        controller:
                            profileController.userPhoneProfileController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return FixedVariables.errorEmpty;
                          } else {
                            if (!value.startsWith('0') || (value.length < 11)) {
                              return FixedVariables.errorPhoneNumFormat;
                            }
                          }
                          return null;
                        },
                      ),
                      _buildMyTextField(
                        labelText: 'آدرس',
                        controller:
                            profileController.userAddressProfileController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return FixedVariables.errorEmpty;
                          } else {
                            if (value.length < 15) {
                              return FixedVariables.errorAddress;
                            }
                          }
                          return null;
                        },
                      ),
                      FixedVariables.bigHeight,
                      _buildMyButton('ثبت تغییرات'),
                    ]),
              ),
            ],
          ),
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
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          UserModel user = UserModel(
            id: userController.readUserFromPref()['id'],
            userName: profileController.userNameProfileController.text,
            userEmail: profileController.userEmailProfileController.text,
            userPassword: profileController.userPasswordProfileController.text,
            userPhone: profileController.userPhoneProfileController.text,
            userAddress: profileController.userAddressProfileController.text,
          );

          userController.editUser(user);
          Get.snackbar('Update Message', 'اطلاعات کاربر به روز رسانی شد');
        }
      },
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

  Widget _buildMyTextField(
      {String? labelText,
      TextEditingController? controller,
      String? Function(String?)? validator,
      Function(String?)? onChanged}) {
    return MyTextField(
      labelText: labelText,
      controller: controller,
      validator: validator,
      textColor: Colors.purple,
      borderRadius: 25,
      colorBorderSide: FixedVariables.purple1,
      fontSize: 20,
      secure: false,
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
      userController.imageFile = File(pickedFile.path);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      userController.imageFile = File(pickedFile.path);
    }
  }
}
