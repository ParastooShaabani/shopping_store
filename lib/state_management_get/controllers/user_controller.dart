import 'dart:convert';
import 'dart:io';
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

  // for Sign Up
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userConfPasswordController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();

  // for Login
  TextEditingController userEmailLoginController = TextEditingController();
  TextEditingController userPassLoginController = TextEditingController();

  // for Login
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  // for Profile & CompleteInformation
  File? imageFile;

  void removeProfileImage() {
    imageFile = null;
    update();
  }

  @override
  void onInit() {
    getUsers();
    getInstanceSharedPref();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();

    userNameController.dispose();
    userPasswordController.dispose();
    userConfPasswordController.dispose();
    userPhoneController.dispose();
    userAddressController.dispose();
    userEmailController.dispose();

    userEmailLoginController.dispose();
    userPassLoginController.dispose();
  }

  void getUsers() {
    _userRepository.getUsers().then((value) {
      userList = value;
    });
  }

  Future<void> addUser(UserModel user) async {
    await _userRepository.postUsers(newUser: user).then((value) {
   //   saveUserToShPref(user);
    });
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

  void exitAccount(String email) {
    if (email!.contains('admin')) {
      adminShPref!.remove('admin');
      print('in admin hazf shod');
    } else {
      userShPref!.remove('user');
      print('in user hazf shod');
    }
  }

  Map<String, dynamic> readUserFromPref() {
    // print('userPref : $userShPref');
    String? user = userShPref!.getString('user');
    return jsonDecode(user!) as Map<String, dynamic>;
  }
}
