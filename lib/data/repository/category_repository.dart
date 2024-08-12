import 'package:dio/dio.dart';
import 'package:ecom/core/api.dart';
import 'package:ecom/data/models/category_model.dart';


class CategoryRepository {
  final _api = Api();
  Future<List<CategoryModel>> fetchAllCategory() async {
    try {
      Response response = await _api.sendRequest.get(
        "/category",
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      } //converting raw Categorydata from apiresponse to model
      return (apiResponse.data as List<dynamic>).map(
        (json) =>
             CategoryModel.fromJson(json)
        
      ).toList();
    } catch (e) {
      rethrow;
    }
  }

   

  
}
