import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_store/state_management_get/models/Product_model.dart';

class ProductRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000/',
      // baseUrl: 'http://10.0.2.2:3000/',
      receiveDataWhenStatusError: true,
      // connectTimeout: const Duration(seconds: 5),
    ),
  );

  Future<Either<String, List<ProductModel>>> getProducts() async {
    var productsList = await _dio.get('product');
    try {
      final result = productsList.data
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();
      return Right(result);
    } catch (e) {
      return Left('left part ${e.toString()}');
    }
  }
}
