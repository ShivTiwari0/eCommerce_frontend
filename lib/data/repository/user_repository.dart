import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom/core/api.dart';
import 'package:ecom/data/models/user_model.dart';

class UserRepository {
  final _api = Api();
  Future<UserModel> createAccount(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post("/user/createAccount",
          data: jsonEncode({"email": email, "password": password}));
           
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      } //converting raw Userdata from apiresponse to model
      return UserModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post("/user/signIn",
          data: jsonEncode({"email": email, "password": password}));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      } //converting raw Userdata from apiresponse to model
      return UserModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }

   Future<UserModel> updateUser(UserModel user,) async {
    try {
      Response response = await _api.sendRequest.put("/user/${user.sId}",
          data:jsonEncode(user.toJson()));
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      } //converting raw Userdata from apiresponse to model
      return UserModel.fromJson(apiResponse.data);
    } catch (e) {
      rethrow;
    }
  }
}
