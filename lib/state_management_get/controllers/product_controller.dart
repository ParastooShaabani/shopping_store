import 'package:get/get.dart';
import 'package:shopping_store/repositories/product_repository.dart';
import 'package:shopping_store/state_management_get/models/Product_model.dart';

class ProductController extends GetxController {

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


  final ProductRepository _productRepository = ProductRepository();

  List<ProductModel> productList = [];
  List<ProductModel> chooseProductsList = [];
  List<ProductModel> favoriteProductsList = [];


  addToChooseProductList(ProductModel productModel) {
    chooseProductsList.add(productModel);
    // update();
   }
   addToFavoriteProductList(ProductModel productModel) {
     favoriteProductsList.add(productModel);
     favoriteProductsList = favoriteProductsList.toSet().toList();
     print(favoriteProductsList);
     update();
   }
   deleteFromFavoriteProductList(ProductModel productModel) {

       for (var product in favoriteProductsList) {
         if (product.productName == productModel.productName) {
           favoriteProductsList.remove(productModel);

         }
       }
    // favoriteProductsList = favoriteProductsList.toSet().toList();
     print(favoriteProductsList);
     update();
   }


  bool changeFavoriteColor(bool isFavourite) {

   isFavourite = !isFavourite;
   update();
   return isFavourite;

  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  Future<void> getProducts() async {
    final resultOrError = await _productRepository.getProducts();
    resultOrError.fold((left) {
      print('left $left');
    }, (List<ProductModel> receivedProductList) {
      productList = receivedProductList.obs;
    });
    update();
  }
}
