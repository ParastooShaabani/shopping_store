import 'package:get/get.dart';

import 'package:shopping_store/state_management_get/controllers/product_controller.dart';
import 'package:shopping_store/state_management_get/models/Product_model.dart';

class HomeController extends GetxController {
    List<ProductModel>? chooseProducts;


  @override
  void onInit() {

    super.onInit();
    ProductController productController = Get.put(ProductController());
   chooseProducts = productController.chooseProductsList;

  }


  List<String> sliderImages = [
    'assets/images/welcome.png',
    'assets/images/welcome.png',
    'assets/images/welcome.png',
  ];
}
