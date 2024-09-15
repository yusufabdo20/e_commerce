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
      emit(
        LoginError(error: e.message ?? ""),
      );
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
