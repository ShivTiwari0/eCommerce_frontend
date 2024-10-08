import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecom/core/api.dart';
import 'package:ecom/data/models/cart_item_model.dart';


class CartRepository {
  final _api = Api();
  Future<List<CartItemModel>> fetchAllCartItem(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/cart/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      } //converting raw Categorydata from apiresponse to model  
     
      return (apiResponse.data as List<dynamic>)
          .map((json) => CartItemModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

   Future<List<CartItemModel>> addToCart(CartItemModel cartItem,String userId) async {
    try {

      Map<String,dynamic>data= cartItem.toJson();
      data["user"]=userId; 

      Response response = await _api.sendRequest.post("/cart", data: jsonEncode(data));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) { 
        throw apiResponse.message.toString();
      } //converting raw Categorydata from apiresponse to model
    
      return (apiResponse.data as List<dynamic>)
          .map((json)=> CartItemModel.fromJson(json))
          .toList();
            
    } catch (e) {
      rethrow;
    }
  }

  
   Future<List<CartItemModel>> removeFromCart(String productId,String userId) async {
    try {

      Map<String,dynamic>data={
        "product":productId,
        "user":userId
      };
     

      Response response = await _api.sendRequest.delete("/cart", data: jsonEncode(data));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      } //converting raw Categorydata from apiresponse to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => CartItemModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
