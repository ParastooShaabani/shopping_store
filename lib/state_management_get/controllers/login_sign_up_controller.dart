import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSignUpController extends GetxController {

  // for Profile & CompleteInformation
  File? imageFile;
  void removeProfileImage() {
    imageFile = null;
    update();
  }

  // for Login
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  // bool checkFieldValidation() {
  //   return _formKey.currentState!.validate();
  // }

  RxBool emailFormat = false.obs;
  RxBool isSecurePass = true.obs;
  RxBool isSecureConfPass = true.obs;

  // RxString _registeredEmail = ''.obs;
  // RxString _registeredPassword = ''.obs;

  String pass = '';
  String conPass = '';

  // RxBool checkInformation(String email, String password) {
  //   return (email == _registeredEmail).obs;
  //   // && password == _registeredPassword;
  // }

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
