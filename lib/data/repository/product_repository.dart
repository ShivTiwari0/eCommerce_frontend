import 'package:dio/dio.dart';
import 'package:ecom/core/api.dart';
import 'package:ecom/data/models/product_model.dart';

class ProductRepository {
  final _api = Api();
  Future<List<ProductModel>> fetchAllProduct() async {
    try {
      Response response = await _api.sendRequest.get(
        "/product", 
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      } //converting raw Productdata from apiresponse to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductByCategory(String categoryId) async {
    try {
      Response response = await _api.sendRequest.get(
        "/product/category/$categoryId",
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      } //converting raw Productdata from apiresponse to model
      return (apiResponse.data as List<dynamic>)
          .map(
            (json) => ProductModel.fromJson(json),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
