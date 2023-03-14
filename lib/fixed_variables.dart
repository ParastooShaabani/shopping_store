import 'package:flutter/material.dart';

class FixedVariables {
  //------------SizedBox-----------
  static SizedBox bigHeight = const SizedBox(height: 40);
  static SizedBox normalHeight = const SizedBox(height: 30);
  static SizedBox littleHeight = const SizedBox(height: 20);

  static SizedBox littleWidth = const SizedBox(width: 10);
  static SizedBox normalWidth = const SizedBox(width: 20);

  //------------Color--------------
  static Color purple1 = const Color.fromARGB(255, 73, 15, 80);
  static Color purple2 = const Color.fromARGB(255, 174, 142, 175);
  static Color red = const Color.fromARGB(255, 166, 27, 32);

  //------------String--------------
  static String errorEmpty = 'فیلد خالی می باشد';
  static String errorWrongLogin = 'اطلاعات وارد شده صحیح نمی باشد';
  static String errorEmailFormat = 'فرمت ایمیل درست نیست';
  static String errorDoubleAccount = 'با این ایمیل قبلا حساب ساخته شده است';
  static String errorPassFormat = 'فرمت پسوورد درست نیست';
  static String errorPassIncorrect = 'پسوورد درست نیست';
  static String errorPhoneNumFormat = 'فرمت شماره تماس درست نیست';
  static String errorAddress = 'آدرس کوتاه است';
  static String shopName = 'آسان مارکت';
}
