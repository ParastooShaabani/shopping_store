import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/favorite_controller.dart';
import 'package:shopping_store/state_management_get/controllers/login_sign_up_controller.dart';
import 'package:shopping_store/state_management_get/controllers/user_controller.dart';
import 'package:shopping_store/state_management_get/models/favorite_model.dart';
import 'package:shopping_store/state_management_get/views/pages/home.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text_field.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginSignUpController loginSignUpController =
      Get.put(LoginSignUpController());

  UserController userController = Get.put(UserController());
  FavoritesController favoritesController = Get.put(FavoritesController());

  @override
  void initState() {
    super.initState();
    userController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                child: Form(
                  key: userController.formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/welcome.png',
                        ),
                        FixedVariables.bigHeight,
                        _buildMyText(' Mellow ', 40),
                        FixedVariables.littleHeight,
                        _buildMyText(' خوش آمدید', 30),
                        _buildMyText('برای شروع وارد حساب خود شوید', 23),
                        FixedVariables.bigHeight,
                        _buildMyTextField('نام کاربری', null, false, null,
                            userController.userEmailLoginController),
                        _buildMyTextField(
                            'رمز عبور',
                            const Icon(Icons.remove_red_eye),
                            true,
                            () => loginSignUpController.showHidePass(),
                            userController.userPassLoginController),
                        FixedVariables.bigHeight,
                        _buildMyButton(),
                      ]),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _findUserFavoriteList() {
    if (!favoritesController
        .findUserIdInFavorites(userController.loginUser!.id!))
    {
      FavoriteModel favorite = FavoriteModel(
          userId: userController.loginUser!.id, favoritesProduct: []);
      favoritesController.addFavorite(favorite);
    }
  }

  Widget _buildMyText(String text, double fontSize) {
    return MyText(
      text: text,
      fontSize: fontSize,
    );
  }

  Widget _buildMyButton() {
    return MyButton(
      onPressed: () {
        if (userController.formKey.currentState!.validate()) {
          _findUserFavoriteList();
        }
      },
      text: 'ورود',
      textColor: Colors.white,
      backgroundColor: FixedVariables.purple1,
      borderSideColor: FixedVariables.purple1,
      borderSideWidth: 2,
      buttonHeight: 70,
      buttonWidth: null,
      fontSize: 20,
      borderRadius: 10,
      padding: 0,
    );
  }

  Widget _buildMyTextField(String hintText, Icon? icon, bool secure,
      Function()? onTap, TextEditingController? controller) {
    return MyTextField(
        controller: controller,
        textColor: Colors.purple,
        borderRadius: 25,
        colorBorderSide: FixedVariables.purple1,
        fontSize: 22,
        hintText: hintText,
        paddingSize: 20,
        validator: (value) {
          if (value!.isEmpty) {
            return FixedVariables.errorEmpty;
          } else if (userController.userLogin(
              userController.userEmailLoginController.text,
              userController.userPassLoginController.text)) {
            userController.saveUserToShPref(userController.loginUser!);
            // _findUserFavoriteList();
            Get.to(Home());
          } else {
            Get.snackbar('WrongLoginError', "اطلاعات وارد شده صحیح نمی باشد");
          }
          return null;
        },
        icon: icon,
        onTap: () {
          // loginSignUpController.showHidePass();
          if (onTap != null) {
            onTap();
          }
        },
        secure: secure ? loginSignUpController.isSecurePass.value : false);
  }
}
