import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/login_sign_up_controller.dart';
import 'package:shopping_store/state_management_get/controllers/user_controller.dart';
import 'package:shopping_store/state_management_get/views/pages/complete_information.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text_field.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final LoginSignUpController loginSignUpController =
      Get.put(LoginSignUpController());

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginSignUpController>(
        assignId: true,
        builder: (loginSignUpController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/welcome.png',
                          ),
                          FixedVariables.littleHeight,
                          _buildMyTextField(
                            hintText: 'ایمیل',
                            controller: userController.userEmailController,
                            secure: false,
                            isConfirmOrUsual: null,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return FixedVariables.errorEmpty;
                              } else if (!loginSignUpController
                                  .checkEmailFormat(value)
                                  .value) {
                                return FixedVariables.errorEmailFormat;
                              } else if (userController.userExist(
                                  userController.userEmailController.text)) {
                                return FixedVariables.errorDoubleAccount;
                              }

                              return null;
                            },
                            onChanged: (value) {
                              loginSignUpController.checkEmailFormat(value!);
                            },
                            icon: loginSignUpController.emailFormat.value
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.email_outlined,
                                    color: Colors.purple,
                                  ),
                          ),
                          _buildMyTextField(
                            hintText: 'نام کاربری',
                            controller: userController.userNameController,
                            icon: null,
                            secure: false,
                            isConfirmOrUsual: null,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return FixedVariables.errorEmpty;
                              }
                              return null;
                            },
                          ),
                          _buildMyTextField(
                            hintText: 'رمز',
                            controller: userController.userPasswordController,
                            icon: const Icon(Icons.remove_red_eye),
                            secure: true,
                            isConfirmOrUsual: false,
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
                            onChanged: (value) {
                              loginSignUpController.pass = (value!);
                            },
                          ),
                          _buildMyTextField(
                            hintText: 'تایید رمز',
                            controller:
                                userController.userConfPasswordController,
                            icon: const Icon(Icons.remove_red_eye),
                            secure: true,
                            isConfirmOrUsual: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return FixedVariables.errorEmpty;
                              } else {
                                if (!loginSignUpController
                                    .checkPasswordFormat(value)
                                    .value) {
                                  return FixedVariables.errorPassFormat;
                                } else if (!loginSignUpController.checkTruePass(
                                    loginSignUpController.pass,
                                    loginSignUpController.conPass)) {
                                  return FixedVariables.errorPassIncorrect;
                                }
                              }
                              return null;
                            },
                            onChanged: (value) {
                              loginSignUpController.conPass = (value!);
                            },
                          ),
                          FixedVariables.bigHeight,
                          _buildMyButton(
                              'رفتن به صفحه تکمیل اطلاعات', userController),
                        ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMyButton(String text, UserController userController) {
    return MyButton(
      text: text,
      textColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Get.to(() => const CompleteInformation());
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
      Icon? icon,
      required bool secure,
      bool? isConfirmOrUsual,
      String? Function(String?)? validator,
      Function(String?)? onChanged,
      TextEditingController? controller}) {
    return MyTextField(
        controller: controller,
        textColor: Colors.purple,
        borderRadius: 25,
        colorBorderSide: FixedVariables.purple1,
        fontSize: 20,
        hintText: hintText,
        paddingSize: 20,
        validator: validator,
        onChanged: onChanged,
        icon: icon,
        onTap: () {
          isConfirmOrUsual!
              ? loginSignUpController.showHideConfPass()
              : loginSignUpController.showHidePass();
        },
        secure: (secure)
            ? ((isConfirmOrUsual!)
                ? loginSignUpController.isSecureConfPass.value
                : loginSignUpController.isSecurePass.value)
            : false);
  }
}
