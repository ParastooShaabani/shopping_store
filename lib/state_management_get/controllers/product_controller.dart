import 'package:get/get.dart';
import 'package:shopping_store/repositories/product_repository.dart';
import 'package:shopping_store/state_management_get/models/Product_model.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  List<ProductModel> productList = [];

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
