import 'package:shopping_store/state_management_get/models/product_model.dart';

class BasketItemsModel {
  BasketItemsModel({
    this.id,
    this.userId,
    this.productList,
  });

  BasketItemsModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    if (json['productList'] != null) {
      productList = [];
      json['productList'].forEach((v) {
        productList?.add(ProductModel.fromJson(v));
      });
    }
  }

  int? id;
  num? userId;
  List<ProductModel>? productList;

  BasketItemsModel copyWith({
    int? id,
    num? userId,
    List<ProductModel>? productList,
  }) =>
      BasketItemsModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productList: productList ?? this.productList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    if (productList != null) {
      map['productList'] = productList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

List<ProductModel> productList = [];
