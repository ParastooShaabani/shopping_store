import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_store/repositories/favorite_repository.dart';
import 'package:shopping_store/state_management_get/models/Product_model.dart';
import 'package:shopping_store/state_management_get/models/basket_items_model.dart';
import 'package:shopping_store/state_management_get/models/favorite_model.dart';

import 'user_controller.dart';

class FavoritesController extends GetxController {
  bool? isFavor;
  SharedPreferences? favoritePref;
  ProductModel? favoriteProduct;
  bool isProductInFavoriteList = false;
  List<FavoriteModel> allFavoriteList = [];

  final FavoritesRepository _favoritesRepository = FavoritesRepository();
  UserController userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    getInstanceSharedPref();
    getFavorites();
  }

  Future<void> getInstanceSharedPref() async {
    favoritePref = await SharedPreferences.getInstance();
  }

  bool? changeFavoriteColor(bool isFavourite) {
    isFavor = !isFavourite;
    update();
    return isFavor;
  }

  addToFavoriteProductList(ProductModel productModel) {
    favoritesList.add(productModel);
    changeFavoriteList();
    update();
  }

  deleteFromFavoriteProductList(ProductModel productModel) {
    for (var element in favoritesList!) {
      if (element.id == productModel.id) {
        isProductInFavoriteList = true;
        favoriteProduct = element;
      }
    }
    favoritesList.remove(favoriteProduct);
    changeFavoriteList();
    update();
  }

  void changeFavoriteList() {
    // for (var element in favoritesList) {
    //   if (element.id == product.id) {
    //     isProductInFavoriteList = true;
    //     favoriteProduct = element;
    //   }
    // }
    // if (isProductInFavoriteList) {
    //   favoritesList.remove(favoriteProduct);
    // } else {
    //   favoritesList.add(product);
    // }

    num userId = userController.readUserFromPref()['id'];

    FavoriteModel favorite = FavoriteModel(
        id: favoritePref!.getInt('favoriteId'),
        userId: userId,
        favoritesProduct: favoritesList);
    _favoritesRepository.editFavoriteList(editedFavorite: favorite);
    update();
  }

  // ch
  void addFavorite(FavoriteModel newFavorite) {
    _favoritesRepository.addFavorite(newFavorite: newFavorite);
    print("in add in f controller");
  }

  void getFavorites() {
    _favoritesRepository.getFavorites().then((value) {
      allFavoriteList = value;
      findUserIdInFavorites(userController.readUserFromPref()['id']);
    });
  }

  void removeFavorite(){
    favoritePref!.remove('favoriteId');
  }

  bool findUserIdInFavorites(num userId) {
    for (var favorite in allFavoriteList) {
      if (favorite.userId == userId) {
        favoritesList = favorite.favoritesProduct!;
        favoritePref!.setInt('favoriteId', favorite.id!);
        return true;
      }
    }
    return false;
  }

  bool searchProductItemsInFavorites(ProductModel product) {
    if (favoritesList.any((element) => element.id == product.id)) {
      return true;
    }
    return false;
  }

}
