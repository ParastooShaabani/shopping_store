import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/favorite_controller.dart';
import 'package:shopping_store/state_management_get/controllers/product_controller.dart';
import 'package:shopping_store/state_management_get/models/Product_model.dart';
import 'package:shopping_store/state_management_get/models/favorite_model.dart';
import 'package:shopping_store/state_management_get/views/pages/details.dart';
import 'package:shopping_store/state_management_get/views/pages/favorite.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_search.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';

class AllProduct extends StatelessWidget {
  AllProduct({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  // final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
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
                    Column(
                      children: [
                        GetBuilder<FavoritesController>(builder: (logic) {
                          return IconButton(
                              onPressed: () {
                                productController
                                        .productList[index].isFavorite =
                                    favoritesController.changeFavoriteColor(
                                        productController
                                            .productList[index].isFavorite!);

                                if (productController
                                    .productList[index].isFavorite!) {
                                  favoritesController.addToFavoriteProductList(
                                      productController.productList[index]);
                                } else {
                                  favoritesController
                                      .deleteFromFavoriteProductList(
                                          productController.productList[index]);
                                }
                              },
                              icon: Icon(
                                Icons.favorite,
                                color:
                                    // productController.productList[index].isFavorite!
                                    favoritesController
                                            .searchProductItemsInFavorites(
                                                productController
                                                    .productList[index])
                                        ? Colors.pink
                                        : Colors.black,
                              ));
                        }),
                        FixedVariables.normalHeight,
                        MyButton(
                          onPressed: () {
                            ProductModel chooseProduct = ProductModel(
                              id: productController.productList[index].id,
                              isProductExist: productController
                                  .productList[index].isProductExist,
                              productName: productController
                                  .productList[index].productName,
                              isSelectedProduct: productController
                                  .productList[index].isSelectedProduct,
                              productDescription: productController
                                  .productList[index].productDescription,
                              productByDiscountPrice: productController
                                  .productList[index].productByDiscountPrice,
                              productCount: productController
                                  .productList[index].productCount,
                              productPrice: productController
                                  .productList[index].productPrice,
                              productRating: productController
                                  .productList[index].productRating,
                              productTime: productController
                                  .productList[index].productTime,
                              isFavorite: productController
                                  .productList[index].isFavorite,
                            );

                            productController
                                .addToChooseProductList(chooseProduct);

                            print(productController.chooseProductsList.length);
                          },
                          text: 'افزودن',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          borderRadius: 12,
                          padding: 0,
                          buttonWidth: 100,
                          buttonHeight: 50,
                          borderSideWidth: 2,
                          borderSideColor: Colors.red,
                        ),
                      ],
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

  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.builder(
        itemCount: productController.images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 0.0, mainAxisSpacing: 5.0),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: InkWell(
                onTap: () {
                  Get.to(() => const Details());
                },
                child: Card(
                    elevation: 5,
                    child: Image.asset(productController.images[index]))),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const MyText(
        text: 'لیست تمام محصولات',
      ),
      backgroundColor: FixedVariables.purple1,
      leading: IconButton(
        onPressed: () {
          Get.to(() => Favorite());
        },
        icon: const Icon(Icons.favorite_border),
        tooltip: 'لیست علاقه مندی ها',
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearch(),

                // delegate to customize the search bar
              );
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
