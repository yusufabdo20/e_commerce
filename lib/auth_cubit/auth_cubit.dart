import 'package:dio/dio.dart';
import 'package:e_commerce/auth_cubit/auth_states.dart';
import 'package:e_commerce/core/api/api_service.dart';
import 'package:e_commerce/models/user_loginn_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/api/app_constants.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginInitial());
  late UserLoginModel user;
  login({
    required String userEmail,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      var data = await ApiSevice().post(
        path: '$baseUrl/login',
        data: {
          "email": userEmail,
          "password": password,
        },
      );
      user = UserLoginModel.fromJson(data["data"]);
      emit(LoginSuccess(user));
    } on DioException catch (e) {
      var type = e.type;
      switch (type) {
        case DioExceptionType.connectionError:
          emit(LoginError(
              error:
                  "Connection Error , try to connect with Internet (WIFI , DATA)"));
          break;

        case DioExceptionType.badCertificate:
          emit(LoginError(
              error:
                  "Caused by an incorrect certificate as configured by ValidateCertificate"));
          break;
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 401) {
            emit(LoginError(error: "Invalid Credentials"));
          } else if (e.response?.statusCode == 500) {
            emit(LoginError(error: "Server Error"));
          } else if (e.response?.statusCode == 404) {
            emit(LoginError(error: "Not Found"));
          } else {
            emit(LoginError(error: "Bad Response"));
          }
          break;
        case DioExceptionType.connectionTimeout:
          emit(LoginError(error: "connectionTimeout"));
          break;
        case DioExceptionType.sendTimeout:
          return 'send timeout';
        case DioExceptionType.receiveTimeout:
          return 'receive timeout';
        case DioExceptionType.cancel:
          return 'Cancel';
        case DioExceptionType.unknown:
          return 'Unkown';
      }
      emit(
        LoginError(error: e.message ?? ""),
      );
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
