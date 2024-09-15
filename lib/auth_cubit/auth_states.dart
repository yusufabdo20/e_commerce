import '../models/user_loginn_model.dart';

abstract class AuthStates {}

class LoginInitial extends AuthStates {}

class LoginSuccess extends AuthStates {
  final UserLoginModel user;
  LoginSuccess(this.user);
}

class LoginError extends AuthStates {
  final String error;
  LoginError({required this.error});
}

class LoginLoading extends AuthStates {}
