import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/favorite_controller.dart';
import 'package:shopping_store/state_management_get/controllers/product_controller.dart';
import 'package:shopping_store/state_management_get/models/Product_model.dart';
import 'package:shopping_store/state_management_get/models/favorite_model.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';

class MySearch extends SearchDelegate {
  ProductController productController = Get.find<ProductController>();
  FavoritesController favoritesController = Get.find<FavoritesController>();

// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return _listToShow();
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return _listToShow();
  }

  Widget _listToShow() {
    List<ProductModel> matchQuery = [];
    for (var product in productController.productList) {
      if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return GetBuilder<ProductController>(
      assignId: true,
      builder: (productController) {
        return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            var result = matchQuery[index];
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Card(
                child: Row(
                  children: [
                    Image.asset(
                      result.productImage!,
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
                        MyText(text: 'نام محصول : ${result.productName}'),
                        MyText(text: 'قیمت : ${result.productPrice}'),
                        MyText(text: 'تعداد : ${result.productCount}'),
                        MyText(text: result.productDescription.toString()),
                        MyText(text: 'موجودی : ${result.isProductExist}'),
                      ],
                    ),
                    FixedVariables.normalWidth,
                    Column(
                      children: [
                        IconButton(
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
                              color:favoritesController
                                  .searchProductItemsInFavorites(
                                  productController
                                      .productList[index])
                                  ? Colors.pink
                                  : Colors.black,
                            )),
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

// GetBuilder<ProductController> buildBodyOfMySearch(var result) {
//   return GetBuilder<ProductController>(
//     assignId: true,
//     builder: (productController) {
//       return ListView.builder(
//         itemCount: productController.productList.length,
//         itemBuilder: (context, index) {
//           return Directionality(
//             textDirection: TextDirection.rtl,
//             child: Card(
//               child: Row(
//                 children: [
//                   Image.asset(
//                     result.productImage!,
//                     height: 150,
//                     width: 150,
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MyText(text: 'نام محصول : ${result.productName}'),
//                       MyText(text: 'قیمت : ${result.productPrice}'),
//                       MyText(text: 'تعداد : ${result.productCount}'),
//                       MyText(text: result.productDescription.toString()),
//                       MyText(text: 'موجودی : ${result.isProductExist}'),
//                     ],
//                   ),
//                   FixedVariables.normalWidth,
//                   Column(
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             productController.productList[index].isFavorite =
//                                 productController.changeFavoriteColor(
//                                     productController
//                                         .productList[index].isFavorite!);
//
//                             ProductModel favoriteProduct = ProductModel(
//                               id: productController.productList[index].id,
//                               isProductExist: productController
//                                   .productList[index].isProductExist,
//                               productName: productController
//                                   .productList[index].productName,
//                               isSelectedProduct: productController
//                                   .productList[index].isSelectedProduct,
//                               productDescription: productController
//                                   .productList[index].productDescription,
//                               productByDiscountPrice: productController
//                                   .productList[index].productByDiscountPrice,
//                               productCount: productController
//                                   .productList[index].productCount,
//                               productPrice: productController
//                                   .productList[index].productPrice,
//                               productRating: productController
//                                   .productList[index].productRating,
//                               productTime: productController
//                                   .productList[index].productTime,
//                               isFavorite: productController
//                                   .productList[index].isFavorite,
//                             );
//
//                             if (productController
//                                 .productList[index].isFavorite!) {
//                               productController
//                                   .addToFavoriteProductList(favoriteProduct);
//                               print(productController
//                                   .favoriteProductsList[index].productName);
//                             }
//                           },
//                           icon: Icon(
//                             Icons.favorite,
//                             color: productController
//                                 .productList[index].isFavorite!
//                                 ? Colors.pink
//                                 : Colors.black,
//                           )),
//                       FixedVariables.normalHeight,
//                       MyButton(
//                         onPressed: () {
//                           ProductModel chooseProduct = ProductModel(
//                             id: productController.productList[index].id,
//                             isProductExist: productController
//                                 .productList[index].isProductExist,
//                             productName: productController
//                                 .productList[index].productName,
//                             isSelectedProduct: productController
//                                 .productList[index].isSelectedProduct,
//                             productDescription: productController
//                                 .productList[index].productDescription,
//                             productByDiscountPrice: productController
//                                 .productList[index].productByDiscountPrice,
//                             productCount: productController
//                                 .productList[index].productCount,
//                             productPrice: productController
//                                 .productList[index].productPrice,
//                             productRating: productController
//                                 .productList[index].productRating,
//                             productTime: productController
//                                 .productList[index].productTime,
//                             isFavorite: productController
//                                 .productList[index].isFavorite,
//                           );
//
//                           productController
//                               .addToChooseProductList(chooseProduct);
//
//                           print(productController.chooseProductsList.length);
//                         },
//                         text: 'افزودن',
//                         backgroundColor: Colors.red,
//                         textColor: Colors.white,
//                         borderRadius: 12,
//                         padding: 0,
//                         buttonWidth: 100,
//                         buttonHeight: 50,
//                         borderSideWidth: 2,
//                         borderSideColor: Colors.red,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }
}
