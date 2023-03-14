import 'package:get/get.dart';

class LoginSignUpController extends GetxController {
  RxBool emailFormat = false.obs;
  RxBool isSecurePass = true.obs;
  RxBool isSecureConfPass = true.obs;


  String pass = '';
  String conPass = '';


  RxBool checkEmailFormat(String value) {
    emailFormat = ((value.contains('@gmail.com')) ? true : false).obs;
    update();
    return emailFormat;
  }

  RxBool checkPasswordFormat(String inputValue) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(inputValue).obs;
  }

  bool checkTruePass(String? pass, String conPass) {
    bool samePass = (pass == conPass) && (pass!.isNotEmpty);
    // _registeredPassword.value = samePass ? pass : '';
    return samePass;
  }

  void showHidePass() {
    isSecurePass.value = isSecurePass.value ? false : true;
    update();
  }

  void showHideConfPass() {
    isSecureConfPass.value = isSecureConfPass.value ? false : true;
    update();
  }
}
