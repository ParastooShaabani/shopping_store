import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/favorite_controller.dart';
import 'package:shopping_store/state_management_get/controllers/product_controller.dart';
import 'package:shopping_store/state_management_get/models/favorite_model.dart';

class Favorite extends StatelessWidget {
  Favorite({Key? key}) : super(key: key);

  // final ProductController productController = Get.find<ProductController>();
  final FavoritesController favoritesController = Get.put(FavoritesController());

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: FixedVariables.purple1,
        title: const Text('لیست علاقه مندی ها'),),
      body: GetBuilder<ProductController>(
        assignId: true,
        builder: (productController) {
          return GetBuilder<FavoritesController>(
            assignId: true,
            builder: (logic) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.builder(
                  itemCount: favoritesList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 50,
                      child: Card(
                        child: Text(favoritesList[index]
                            .productName.toString()),
                      ),
                    );
                  },),
              );
            },
          );
        },
      ),
    );
  }
}
