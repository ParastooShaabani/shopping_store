import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/user_controller.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';

class ShowUser extends StatelessWidget {
  ShowUser({Key? key}) : super(key: key);
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBodyOfAllProduct(),
    );
  }

  GetBuilder<UserController> buildBodyOfAllProduct() {
    return GetBuilder<UserController>(
      assignId: true,
      builder: (productController) {
        return ListView.builder(
          itemCount: userController.userList.length,
          itemBuilder: (context, index) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Card(
                child: Row(
                  children: [
                    Image.asset(
                      userController.userList[index].userImage!,
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                            text:
                                'نام محصول : ${userController.userList[index].userName}'),
                        MyText(
                            text:
                                'قیمت : ${userController.userList[index].userPassword}'),
                        MyText(
                            text:
                                'تعداد : ${userController.userList[index].userAddress}'),
                        MyText(
                            text: userController.userList[index].userPhone
                                .toString()),
                        MyText(
                            text:
                                'موجودی : ${productController.userList[index].userPhone}'),
                      ],
                    ),
                    FixedVariables.normalWidth,
                    const MyButton(
                      text: 'افزودن',
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      borderRadius: 12,
                      padding: 0,
                      buttonWidth: 100,
                      buttonHeight: 50,
                      borderSideWidth: 2,
                      borderSideColor: Colors.red,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
