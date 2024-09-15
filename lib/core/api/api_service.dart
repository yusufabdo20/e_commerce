import 'package:dio/dio.dart';
import 'package:e_commerce/models/user_loginn_model.dart';

class ApiSevice {
  final Dio _dio = Dio();
  Future post({
    required String path,
    Object? data,
  }) async {
    final response = await _dio.post(
      path, // Path
      data: data,
    );
    return response.data;
  }
}
