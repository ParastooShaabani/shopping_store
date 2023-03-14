import 'package:shopping_store/state_management_get/models/Product_model.dart';

class FavoriteModel {
  FavoriteModel({
    this.id,
    this.userId,
    this.favoritesProduct,
  });

  FavoriteModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    if (json['favoritesProduct'] != null) {
      favoritesProduct = [];
      json['favoritesProduct'].forEach((v) {
        favoritesProduct?.add(ProductModel.fromJson(v));
      });
    }
  }

  int? id;
  num? userId;
  List<ProductModel>? favoritesProduct;

  FavoriteModel copyWith({
    int? id,
    num? userId,
    List<ProductModel>? favoritesProduct,
  }) =>
      FavoriteModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        favoritesProduct: favoritesProduct ?? this.favoritesProduct,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    if (favoritesProduct != null) {
      map['favoritesProduct'] =
          favoritesProduct?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
List<ProductModel> favoritesList = [];
