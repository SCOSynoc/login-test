
import 'package:flutter/cupertino.dart';

@immutable
sealed class AuthStates {}


class AuthInitial extends AuthStates {}

class SuccessfullyLogin extends AuthStates {}

class AuthLoading extends AuthStates {}

class LoginFailed extends AuthStates {
  final String msg;
  LoginFailed({required this.msg});
}

class SigInSuccess extends AuthStates {}

class SigInFailed extends AuthStates {
  final String msg;
  SigInFailed({required this.msg});
}