
import 'package:flutter/cupertino.dart';

@immutable
sealed class AuthEvents {}

class LoginRequested extends AuthEvents {
  final String email;
  final String password;
  LoginRequested({required this.email,required this.password});
}


class ValidateEmailRequest extends AuthEvents {
   final String email;
   ValidateEmailRequest({required this.email});
}

class SignInRequested extends AuthEvents {
  final String email;
  final String password;
  final String name;
  final String mobile;
  SignInRequested( {required this.email,required this.password,required this.name, required this.mobile,});
}