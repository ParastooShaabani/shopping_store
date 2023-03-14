import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/state_management_get/controllers/user_controller.dart';

class ProfileController extends GetxController {
  UserController userController = Get.put(UserController());

  TextEditingController userNameProfileController = TextEditingController();
  TextEditingController userPasswordProfileController = TextEditingController();
  TextEditingController userPhoneProfileController = TextEditingController();
  TextEditingController userAddressProfileController = TextEditingController();
  TextEditingController userEmailProfileController = TextEditingController();




  @override
  void onInit() {
    super.onInit();
    userNameProfileController.text = userController.readUserFromPref()['userName'];
    userPasswordProfileController.text = userController.readUserFromPref()['userPassword'];
    userPhoneProfileController.text = userController.readUserFromPref()['userPhone'];
    userAddressProfileController.text = userController.readUserFromPref()['userAddress'];
    userEmailProfileController.text = userController.readUserFromPref()['userEmail'];
 }

  @override
  void dispose() {
    super.dispose();

    userNameProfileController.dispose();
    userPasswordProfileController.dispose();
    userPhoneProfileController.dispose();
    userAddressProfileController.dispose();
    userEmailProfileController.dispose();
  }
}
