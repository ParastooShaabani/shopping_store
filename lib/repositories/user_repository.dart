import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_store/state_management_get/models/user_model.dart';

class UserRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000/',
      receiveDataWhenStatusError: true,
    ),
  );

  Future<Either<String, List<UserModel>>> getUsers() async {
    var userList = await _dio.get('user');
    try {
      final result = userList.data
          .map<UserModel>((e) => UserModel.fromJson(e))
          .toList();
      return Right(result);
    } catch (e) {
      return Left('left part ${e.toString()}');
    }
  }

  Future<Either<String, UserModel>> postUsers({required UserModel newUser}) async {

    try {
      var response = await _dio.post('user',data: newUser.toJson());
      UserModel userModel = UserModel.fromJson(response.data);
      return Right(userModel);
    } catch (e) {
      return Left('left part add user errorrrrr ${e.toString()}');
    }
  }

  Future<UserModel> editUser({required UserModel editedUser, required num userId}) async{
    try{
      var response = await _dio.put('user/${userId.toString()}', data: editedUser.toJson());
      UserModel newVersionOfUser = UserModel.fromJson(response.data);
      return newVersionOfUser;
    }
    catch(e){
      print('left part edit user errorrrrr  ${e.toString()}');
      return throw e.toString();
    }
  }
}
