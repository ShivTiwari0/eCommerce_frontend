import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String Base_Url = 'http://192.168.1.36:5000/api/';
const Map<String, dynamic> DEAFULT_HEADERS = {
  'Content-Type': 'Application/json' 
}; 
  
class Api {
  final Dio _dio = Dio();
  Api() {
    _dio.options.baseUrl = Base_Url;
    _dio.options.headers = DEAFULT_HEADERS;    
    _dio.interceptors.add(PrettyDioLogger(
        responseBody: true,
        requestBody: true,  
        requestHeader: true,
        responseHeader: true));
  }
  Dio get sendRequest => _dio;
}
 
class ApiResponse {
  bool success;
  dynamic data;
  String? message;
  ApiResponse({
    required this.success,
    this.data,
    this.message,
  });
  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
      success: data["success"],
      data: data["data"],
      message: data["message"] ?? "Unexpected Error",
    );
  }
}
