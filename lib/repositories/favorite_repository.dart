import 'package:dio/dio.dart';
import 'package:shopping_store/state_management_get/models/favorite_model.dart';

class FavoritesRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000/',
      // receiveDataWhenStatusError: true,
    ),
  );

  Future<FavoriteModel> addFavorite(
      {required FavoriteModel newFavorite}) async {
    try {
      var response = await _dio.post('favorites', data: newFavorite.toJson());
      FavoriteModel retrievedFavorite = FavoriteModel.fromJson(response.data);
      return retrievedFavorite;
    } catch (e) {
      print('add favorite errorrrrr: ${e.toString()}');
      return throw e.toString();
    }
  }

  Future<List<FavoriteModel>> getFavorites() async {
    var response = await _dio.get('favorites');
    try {
      final favoriteResult = await response.data.map<FavoriteModel>((element) {
        return FavoriteModel.fromJson(element);
      }).toList();
      return favoriteResult;
    } catch (e) {
      print('****get favorite error*****: ${e.toString()}');
      return throw e.toString();
    }
  }

  Future<FavoriteModel> editFavoriteList(
      {required FavoriteModel editedFavorite}) async {
    try {
      var response = await _dio.put('favorites/${editedFavorite.id.toString()}',
          data: editedFavorite.toJson());
      FavoriteModel retrievedFavorite = FavoriteModel.fromJson(response.data);
      return retrievedFavorite;
    } catch (e) {
      print('***edit Favorite error*** ${e.toString()}');
      return throw e.toString();
    }
  }
}
