class ProductModel {
  ProductModel({
      this.id, 
      this.productImage, 
      this.productName, 
      this.productDescription, 
      this.productTime, 
      this.productPrice, 
      this.productByDiscountPrice, 
      this.isProductExist, 
      this.productRating, 
      this.productCount, 
      this.isSelectedProduct, 
      this.isFavorite,});

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    productImage = json['productImage'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    productTime = json['productTime'];
    productPrice = json['productPrice'];
    productByDiscountPrice = json['productByDiscountPrice'];
    isProductExist = json['isProductExist'];
    productRating = json['productRating'];
    productCount = json['productCount'];
    isSelectedProduct = json['isSelectedProduct'];
    isFavorite = json['isFavorite'];
  }
  num? id;
  String? productImage;
  String? productName;
  String? productDescription;
  String? productTime;
  num? productPrice;
  num? productByDiscountPrice;
  bool? isProductExist;
  num? productRating;
  num? productCount;
  bool? isSelectedProduct;
  bool? isFavorite;
ProductModel copyWith({  num? id,
  String? productImage,
  String? productName,
  String? productDescription,
  String? productTime,
  num? productPrice,
  num? productByDiscountPrice,
  bool? isProductExist,
  num? productRating,
  num? productCount,
  bool? isSelectedProduct,
  bool? isFavorite,
}) => ProductModel(  id: id ?? this.id,
  productImage: productImage ?? this.productImage,
  productName: productName ?? this.productName,
  productDescription: productDescription ?? this.productDescription,
  productTime: productTime ?? this.productTime,
  productPrice: productPrice ?? this.productPrice,
  productByDiscountPrice: productByDiscountPrice ?? this.productByDiscountPrice,
  isProductExist: isProductExist ?? this.isProductExist,
  productRating: productRating ?? this.productRating,
  productCount: productCount ?? this.productCount,
  isSelectedProduct: isSelectedProduct ?? this.isSelectedProduct,
  isFavorite: isFavorite ?? this.isFavorite,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productImage'] = productImage;
    map['productName'] = productName;
    map['productDescription'] = productDescription;
    map['productTime'] = productTime;
    map['productPrice'] = productPrice;
    map['productByDiscountPrice'] = productByDiscountPrice;
    map['isProductExist'] = isProductExist;
    map['productRating'] = productRating;
    map['productCount'] = productCount;
    map['isSelectedProduct'] = isSelectedProduct;
    map['isFavorite'] = isFavorite;
    return map;
  }

}