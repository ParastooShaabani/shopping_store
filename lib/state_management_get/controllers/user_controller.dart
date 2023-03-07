import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_store/repositories/user_repository.dart';
import 'package:shopping_store/state_management_get/models/user_model.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  UserModel? userModel;
  List<UserModel> userList = [];
  SharedPreferences? userShPref;
  SharedPreferences? adminShPref;
  UserModel? loginUser;

  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userConfPasswordController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getUsers();
    getInstanceSharedPref();
  }

  Future<void> getUsers() async {
    final resultOrError = await _userRepository.getUsers();
    resultOrError.fold((left) {
      print('left $left');
    }, (List<UserModel> receivedUserList) {
      userList = receivedUserList.obs;
    });
    update();
  }

  Future<void> addUser(UserModel user) async {
    _userRepository.postUsers(newUser: user);
    // saveUserToShPref(user);
    update();
  }

  Future<void> editUser(UserModel user) async {
    _userRepository.editUser(editedUser: user, userId: user.id!).then((value) {
      print('userUpdated');
    });
    saveUserToShPref(user);
  }

  // if exit can't sign up , repeat user
  bool userExist(String userEmail) {
    for (var user in userList) {
      if (user.userEmail == userEmail) {
        return true;
      }
    }
    return false;
  }

  // user can login
  bool userLogin(String userEmail, String pass) {
    for (var user in userList) {
      if (user.userEmail == userEmail && user.userPassword == pass) {
        loginUser = user;
        return true;
      }
    }
    return false;
  }

  Future<void> getInstanceSharedPref() async {
    userShPref = await SharedPreferences.getInstance();
    adminShPref = await SharedPreferences.getInstance();
  }

  void saveUserToShPref(UserModel user) {
    Map<String, dynamic> userModel = {
      'id': user.id,
      'userImage': user.userImage,
      'userName': user.userName,
      'userPassword': user.userPassword,
      'userPhone': user.userPhone,
      'userAddress': user.userAddress,
      "userEmail": user.userEmail
    };
    userShPref!.setString('user', jsonEncode(userModel));

    if (user.userName!.contains('admin')) {
      adminShPref!.setString('admin', jsonEncode(userModel));
    }
  }
  void exitAccount(UserModel user) {
    if (user.userName!.contains('admin')) {
      adminShPref!.remove('admin');
    }
    else {
      userShPref!.remove('user');
    }
  }

  Map<String, dynamic> readUserFromPref() {
    print('userPref : $userShPref');
    String? user = userShPref!.getString('user');
    return jsonDecode(user!) as Map<String, dynamic>;
  }
}
