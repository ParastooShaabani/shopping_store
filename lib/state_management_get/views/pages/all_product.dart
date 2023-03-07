import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/product_controller.dart';
import 'package:shopping_store/state_management_get/views/pages/details.dart';     /// check it
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';

class AllProduct extends StatelessWidget {
  AllProduct({Key? key}) : super(key: key);

  List<String> images = [
    'assets/images/welcome.png',
    'assets/images/welcome.png',
    'assets/images/welcome.png',
    'assets/images/welcome.png',
    'assets/images/welcome.png',
    'assets/images/welcome.png',
    'assets/images/welcome.png',
    'assets/images/welcome.png',
    'assets/images/welcome.png',
  ];
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: buildBodyOfAllProduct(),
    );
  }

  GetBuilder<ProductController> buildBodyOfAllProduct() {
    return GetBuilder<ProductController>(
      assignId: true,
      builder: (productController) {
        return ListView.builder(
          itemCount: productController.productList.length,
          itemBuilder: (context, index) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Card(
                child: Row(
                  children: [
                    Image.asset(
                      productController.productList[index].productImage!,
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
                            'نام محصول : ${productController.productList[index].productName}'),
                        MyText(
                            text:
                            'قیمت : ${productController.productList[index].productPrice}'),
                        MyText(
                            text:
                            'تعداد : ${productController.productList[index].productCount}'),
                        MyText(
                            text: productController
                                .productList[index].productDescription
                                .toString()),
                        MyText(
                            text:
                            'موجودی : ${productController.productList[index].isProductExist}'),
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
  // Widget _buildGridView() {
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: GridView.builder(
  //       itemCount: images.length,
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2, crossAxisSpacing: 0.0, mainAxisSpacing: 5.0),
  //       itemBuilder: (BuildContext context, int index) {
  //         return Padding(
  //           padding: const EdgeInsets.only(left: 5.0, right: 5.0),
  //           child: InkWell(
  //               onTap: () {
  //                 Get.to(() => const Details());
  //               },
  //               child: Card(elevation: 5, child: Image.asset(images[index]))),
  //         );
  //       },
  //     ),
  //   );
  // }

  AppBar _buildAppBar() {
    return AppBar(

      centerTitle: true,
      title: const MyText( text: 'لیست تمام محصولات',),
      backgroundColor: FixedVariables.purple1,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
