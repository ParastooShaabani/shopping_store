import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/login_sign_up_controller.dart';
import 'package:shopping_store/state_management_get/controllers/user_controller.dart';
import 'package:shopping_store/state_management_get/models/user_model.dart';
import 'package:shopping_store/state_management_get/views/pages/welcome.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_dialog.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text_field.dart';

class CompleteInformation extends StatefulWidget {
  const CompleteInformation({Key? key}) : super(key: key);

  @override
  State<CompleteInformation> createState() => _CompleteInformationState();
}

class _CompleteInformationState extends State<CompleteInformation> {
  final LoginSignUpController loginSignUpController =
      Get.find<LoginSignUpController>();

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: loginSignUpController.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FixedVariables.bigHeight,
                _buildProfilePicture(context),
                FixedVariables.littleHeight,
                _buildMyTextField(
                  hintText: 'شماره تماس',
                  controller: userController.userPhoneController,
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
                  hintText: 'آدرس 1',
                  maxLines: 4,
                  controller: userController.userAddressController,
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
                _buildMyTextField(
                  hintText: 'آدرس 2',
                  maxLines: 4,
                  controller: userController.userAddressController,
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
                FixedVariables.littleHeight,
                _buildMyButton('ثبت'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyButton(String text) {
    return MyButton(
      text: text,
      textColor: Colors.white,
      onPressed: () {
        if (loginSignUpController.formKey.currentState!.validate()) {
          UserModel user = UserModel(
            userName: userController.userNameController.text,
            userPassword: userController.userPasswordController.text,
            userEmail: userController.userEmailController.text,
            userPhone: userController.userPhoneController.text,
            userAddress: userController.userAddressController.text,
          );
          userController.addUser(user);
          print('do you save??');
          Get.to(() => const Welcome());
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
      {required String hintText,
      int? maxLines,
      String? Function(String?)? validator,
      TextEditingController? controller,
      Function(String?)? onChanged}) {
    return MyTextField(
      controller: controller,
      maxLines: maxLines,
      secure: false,
      textColor: Colors.purple,
      borderRadius: 25,
      colorBorderSide: FixedVariables.purple1,
      fontSize: 20,
      hintText: hintText,
      paddingSize: 20,
      onChanged: onChanged,
      validator: validator,
      //     (value) {
      //   if (value!.isEmpty) {
      //     return FixedVariables.errorEmpty;
      //   }
      //   return null;
      // }
    );
  }

  Widget _buildProfilePicture(BuildContext context) {
    return InkWell(
      onTap: () {
        _showMyDialog(context);
      },
      child: Container(
        height: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/unknown_person.png'),
              fit: BoxFit.fitHeight),
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
                onPressedCh2: // ignore: invalid_use_of_visible_for_testing_member
                    () {
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
